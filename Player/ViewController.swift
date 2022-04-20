//
//  ViewController.swift
//  Player
//
//  Created by Кирилл on 19.04.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var atlView: UIView!
    @IBOutlet weak var sakoView: UIView!
    @IBOutlet weak var atlLabel: UILabel!
    @IBOutlet weak var atlImage: UIImageView!
    @IBOutlet weak var sakoImge: UIImageView!
    @IBOutlet weak var sakoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //делаем границы для вью с песнями
        atlView.layer.borderColor = UIColor.gray.cgColor
        atlView.layer.borderWidth = 0.3
        atlView.layer.cornerRadius = 15
        //делаем скругление для картинки
        atlImage.layer.cornerRadius = 15
        sakoView.layer.borderColor = UIColor.gray.cgColor
        sakoView.layer.cornerRadius = 15
        sakoView.layer.borderWidth = 0.3
        //делаем скругление для второй картинки
        sakoImge.layer.cornerRadius = 15
    }
    //передаем данные с первого экрана на второй
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //переход для первого трека
        if segue.identifier == "SakoIsoyan" {
            if let playerController = segue.destination as? FirstSongPlayController {
            //проверяем успешность нахождения песни
            do {
                if let audioPath = Bundle.main.path(forResource: "Sako Isoyan - Wow", ofType: "mp3") {
                    try playerController.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                }
            } catch {
                print("Error")
            }
            //записываем данные с первой вью в переменные второй вью
                playerController.nameSong = sakoLabel.text!
                playerController.image = sakoImge.image!
                playerController.durationSong = 353
                //запуск воспроизведения при переходе
                playerController.player.play()
            }
        }
        //переход для второго трека
        if segue.identifier == "ATL" {
            if let playerController = segue.destination as? FirstSongPlayController {
                do {
                    if let audioPath = Bundle.main.path(forResource: "ATL_Yunost_89", ofType: "mp3") {
                        try playerController.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                    }
                } catch {
                    print("Error")
                }
                //записываем данные с первой вью в переменные второй вью
                playerController.nameSong = atlLabel.text!
                playerController.image = atlImage.image!
                playerController.durationSong = 242
                //запуск воспроизведения при переходе
                playerController.player.play()
            }
        }
    }

}


