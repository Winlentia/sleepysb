//
//  PredefineActionButton.swift
//  sleepysb
//
//  Created by Winlentia on 26.09.2023.
//

import Cocoa

class PredefineActionButton: NSButton {
    var seconds: Int?
    
    func setupView(seconds: Int){
        self.seconds = seconds
        self.title = seconds.secondsToHoursMinutesSecondsString()
    }
}
