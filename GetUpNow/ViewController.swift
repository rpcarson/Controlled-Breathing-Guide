//
//  ViewController.swift
//  GetUpNow
//
//  Created by Reed Carson on 5/9/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DisplayType {
    
    var timer = Timer()
    var audioPlayer = AudioPlayer()
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var timeSelector: UISegmentedControl!
    
    @IBOutlet weak var breathSlider: BreathMeter!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        breathSlider.progressViewStyle = .Bar
        breathSlider.setProgress(0, animated: false)
        breathSlider.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        
        UIView.animateWithDuration(3, animations: { () -> Void in
            self.breathSlider.setProgress(1.0, animated: true)
        })
        
        countLabel.text = "0"
        timeRemainingLabel.text = "00.00"
        timer.displayDelegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func start() {
        
        var selectedLength: Timer.Length {
            switch timeSelector.selectedSegmentIndex {
            case 0: return .Five
            case 1: return .Ten
            case 2: return .Fifteen
            case 3: return .Twenty
            case 4: return .Unlimited
            default: return .Five
            }
        }
        
        print("slected time length (\(selectedLength)")
        
        timer.length = selectedLength
        
        timer.startTimer()
        
        print("STart button pressed")
        print("Current Mode: \(timer.countMode)")
        
    }
    
    @IBAction func stop() {
        
        timer.stopTimer()
        
        print("Stop button pressed")
    }
    
    func updateBreathMeter() {
        var progressPercentage: Float {
         return ((Float(timer.currentCount) / Float(timer.countMode.rawValue)))
        }
        
        dispatch_async(dispatch_get_main_queue()) {
           self.breathSlider.setProgress(progressPercentage, animated: true)
        }
        
//        UIView.animateWithDuration(300) { () -> Void in
//            self.breathSlider.setProgress(0, animated: true)
//
//
//        }
        
        print("progress \(breathSlider.progress)")
        
        
        print("time remaining \(timer.timeRemaining)")
        print("length \(timer.length.rawValue)")
        print("prog percent \(progressPercentage)")
    }
    
    func updateLabel() {
        
        
       // updateBreathMeter()
        
        countLabel.text = String(timer.currentCount)
        
        if timer.length == .Unlimited {
            timeRemainingLabel.text = "00.00"
            return
        }
        
        timeRemainingLabel.text = timer.convertIntToMinutes(timer.timeRemaining)
        
       // audioPlayer.playSound()
        
       // print("Update label called")
    }
    
    @IBAction func switchMode(sender: UIButton) {
        
        timer.stopTimer()
       
        guard let label = sender.titleLabel?.text else { return }
        
        switch label {
        case "4/2": timer.countMode = .FourTwo; print("4/2 mode")
        case "8/4": timer.countMode = .EightFour; print("8/4 mode")
        case "16/8": timer.countMode = .SixteenEight; print("16/8 mode")
        case "32/16": timer.countMode = .ThirtysixSixteen; print("32/16 mode")
        default: return
        }
        
    }
    
}

