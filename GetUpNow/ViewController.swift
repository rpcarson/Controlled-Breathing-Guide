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
    
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countLabel.text = "0"
        timeRemainingLabel.text = "00.00"
        timer.displayDelegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func start() {
        
        timer.startTimer()
        
        print("STart button pressed")
        print("Current Mode: \(timer.countMode)")
        
    }
    
    @IBAction func stop() {
        
        timer.stopTimer()
        
        print("Stop button pressed")
    }
    
    func updateLabel() {
        
        countLabel.text = String(timer.currentCount)
        
        timeRemainingLabel.text = timer.convertIntToMinutes(timer.timeRemaining)
        
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

