//
//  ViewController.swift
//  Egg Timer
//
//  Created by Mac on 17.04.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
//    softTime = 5 min
//    mediumTime = 7 min
//    hardTime = 12 min
    let eggTimes: [String : Int] = ["Soft": 3, "Medium": 4, "Hard": 7]
    //for faster alarm I change 5 min - 3 sec, 7 min - 4 sec, 12 min - 7 sec
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }

    @IBAction func hardnessSelection(_ sender: UIButton) {
        
       
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
            
        }
        else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
        
    }
    
}

