//
//  Timer.swift
//  GetUpNow
//
//  Created by Reed Carson on 5/9/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit


protocol DisplayType {
    func updateLabel()
}




class Timer {
    
    var timer = NSTimer()
    var currentCount: Int = 0 {
        didSet {
            displayDelegate?.updateLabel()
           // print("CurrentCount = \(currentCount)")
        }
    }
    var currentTime: Int = 0 {
        didSet {
           // print("CurrentTime = \(currentTime)")
        }
    }
    
    var timeRemaining: Int {
            return length.rawValue - currentTime
    }
    
    var length: Length = .Five
    var countMode: CountMode = .FourTwo
    var displayDelegate: DisplayType?
    var holdBreath: Bool = false
        
   
    func startTimer() {
        
        currentTime = 0

        // timerInterval set below 1 for testing
        timer = NSTimer(timeInterval: 0.25, target: self, selector: #selector(Timer.count), userInfo: nil, repeats: true)
        
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        
        print("Timer: startTimer called")
        
        
    }
    
    func stopTimer() {
        timer.invalidate()
        currentCount = 0
    }
    
    private  func incrementTimer() {
        
        currentTime += 1
        
        if timeRemaining == 0 {
            stopTimer()
        }
        
    }
    
    private func countBreath() {
        
        currentCount += 1
        
        if !holdBreath {
            if currentCount == countMode.rawValue + 1 {
                currentCount = 1
                holdBreath = true
            }
        } else {
            if currentCount == (countMode.rawValue / 2) + 1{
                currentCount = 1
                holdBreath = false
            }
        }
        
        // print("Timer: countBreath called")
    }
    
    @objc private func count() {
        incrementTimer()
        countBreath()
        
      //  print("Timer: Count called")
    }
    
    enum Length: Int {
        // set short for testing
        case Five = 60
        case Ten = 600
        case Fifteen = 900
        case Twenty = 1200
        case Unlimited = 9999
    }
    
    enum CountMode: Int {
        case FourTwo = 4
        case EightFour = 8
        case SixteenEight = 16
        case ThirtysixSixteen = 32
    }
    
}


extension Timer {
    
    func convertIntToMinutes(number: Int) -> String {
        
        var seconds = String(Int(number % 60))
        var minutes = String(Int(number / 60))
        
        if seconds.characters.count == 1 {
            seconds = "0" + seconds
        }
        
        if minutes.characters.count == 1 {
            minutes = "0" + minutes
        }
        
        return "\(minutes):\(seconds)"
    }
}

