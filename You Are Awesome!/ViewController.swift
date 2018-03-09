//
//  ViewController.swift
//  You Are Awesome!
//
//  Created by Estevan Feliz on 1/21/18.
//  Copyright © 2018 Feliz Studios. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var awesomeImage: UIImageView!
    @IBOutlet weak var soundSwitch: UISwitch!
    var awesomePlayer = AVAudioPlayer()
    var index = -1
    var imageNumber = -1
    let numberOfImages = 8
    var soundNumber = -1
    let numberOfSounds = 6
    
    // Code below executes when the app's view first loads
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - My Own Functions
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        // Can we load the sound?
        if let sound = NSDataAsset(name:soundName){
            // check if sound.data is a sound file
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: data in \(soundName) couldn't be played as a sound.")
            }
        } else {
            // if reading in the NSDataAsset didn't work, tell the user / report the error.
            print("ERROR: file \(soundName) didn't load.")
        }
    }
    
    func randomNumber(lastNum: Int, maximum: Int) -> Int {
        var newIndex = -1
        repeat {
            newIndex = Int(arc4random_uniform(UInt32(maximum)))
        } while lastNum == newIndex
        return newIndex
    }
    
    // MARK: - Actions
    
    @IBAction func soundSwitchPressed(_ sender: UISwitch) {
        if !soundSwitch.isOn{
            // Stop playing
            if awesomePlayer.isPlaying {
                awesomePlayer.stop()
            }
        }
    }
    @IBAction func messageButtonPressed(_ sender: UIButton) {
        
        let messages = ["You Are Fantastic!",
                        "You Are Great!",
                        "You Are Amazing!",
                        "When the Genius Bar needs help, they call you!",
                        "You Brighten My Day!"]
        
        index = randomNumber(lastNum: index, maximum: messages.count)
        messageLabel.text = messages[index]
        
        awesomeImage.isHidden = false
        imageNumber = randomNumber(lastNum: imageNumber, maximum: numberOfImages)
        awesomeImage.image = UIImage(named: "image\(imageNumber)")
        
        // Play a sound
        if soundSwitch.isOn == true {
            soundNumber = randomNumber(lastNum: soundNumber, maximum: numberOfSounds)
            let soundName = "sound" + String(soundNumber)
            playSound(soundName: soundName, audioPlayer: &awesomePlayer)
        }
        
        //        var randomIndex = Int(arc4random_uniform(UInt32(messages.count)))
        //        messageLabel.text = messages[randomIndex]
        
        /*
        index += 1
        if index == messages.count {
            index = 0
        }
        messageLabel.text = messages[index]
        */
        
//        let message1 = "You Are Da Bomb!"
//        let message2 = "You Are Great!"
//        let message3 = "You Are Amazing!"
//
//        if messageLabel.text == message1{
//            messageLabel.text = message2
//        } else if messageLabel.text == message2 {
//            messageLabel.text = message3
//        } else {
//            messageLabel.text = message1
//        }
    }
    
}

