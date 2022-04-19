//
//  FirstSongPlayController.swift
//  Player
//
//  Created by Кирилл on 19.04.2022.
//

import UIKit
import AVFoundation

class FirstSongPlayController: UIViewController {
    //создаем аутлеты для элементов вью
    @IBOutlet weak var imageArt: UIImageView!
    @IBOutlet weak var nameSongLabel: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSliderOutlet: UISlider!
    @IBOutlet weak var nowDurationLabel: UILabel!
    //создаем переменную плеера
    var player = AVAudioPlayer()
    //создаем переменные для передачи данных между экранами
    var nameSong = ""
    var durationSong = ""
    var image = UIImage()
    //создаем переменную таймера для слайдера и времени песни
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //заполняем кнопку изображением паузы по умолчанию
        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        //выставляем значения для слайдера времени песни
        durationSlider.minimumValue = 0.0
        durationSlider.value = Float(player.currentTime)
        durationSlider.maximumValue = Float(player.duration)
        //задаем обновление слайдера для отображения времени песни
        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        // присваиваем данные для лейблов и выставляем картинку
        nameSongLabel.text = nameSong
        durationLabel.text = durationSong
        imageArt.image = image
        //задаем обновление лейбла для отображения времени с начала песни
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.pause()
    }
    //регулировка громкости
    @IBAction func volumeSliderAction(_ sender: UISlider) {
        self.player.volume = sender.value
    }
    //кнопка воспроизведения
    @IBAction func playPauseAction(_ sender: UIButton) {
        if self.player.isPlaying {
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player.pause()
        } else {
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            player.play()
        }
    }
    //кнопка поделится
    @IBAction func senderButton(_ sender: UIButton) {
        let apple = [URL(string: "http://apple.com")!]
        let activity = UIActivityViewController(activityItems: apple, applicationActivities: nil)
        present(activity, animated: true)
    }
    //кнопка для закрытия плеера
    @IBAction func closePlayer(_ sender: UIButton) {
        player.pause()
        self.dismiss(animated: true)
    }
    //перемотка песни через слайдер
    @IBAction func durationSliderAction(_ sender: UISlider) {
        self.player.currentTime = TimeInterval(sender.value)
    }
    //функция обновления лейбла с текущим временем песни
    @objc func updateTime() {
        let timePlayed = player.currentTime
        let minutes = Int(timePlayed / 60)
        let seconds = Int(timePlayed.truncatingRemainder(dividingBy: 60))
        nowDurationLabel.text = NSString(format: "%02d:%02d", minutes, seconds) as String
    }
    //функция обновления слайдера по текущему времени песни
    @objc func updateSlider(){
           durationSlider.value = Float(player.currentTime)
       }
}
