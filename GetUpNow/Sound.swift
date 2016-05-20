//
//  Sound.swift
//  GetUpNow
//
//  Created by Reed Carson on 5/9/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import Foundation
import AudioToolbox


struct AudioPlayer {
    
    
    var soundURL: NSURL {
        let fileName: String = "rimOne"
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "wav")!
        return NSURL(fileURLWithPath: path)
        
    }
    
    var sound: SystemSoundID = 0
    
    mutating func playSound() {
        AudioServicesCreateSystemSoundID(soundURL, &sound)
        AudioServicesPlaySystemSound(sound)
    }
    
}

