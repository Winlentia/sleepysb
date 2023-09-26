//
//  Int+Extensions.swift
//  sleepysb
//
//  Created by Winlentia on 26.09.2023.
//

import Foundation

extension Int {
    func secondsToHoursMinutesSecondsString() -> String {
        let (h, m, s) = secondsToHoursMinutesSecondsTople()
        var returnString = ""
        if h != 0 {
            returnString += "\(h) Hours"
        }
        if m != 0 {
            if !returnString.isEmpty {
                returnString += ", "
            }
            returnString += "\(m) Minutes"
        }
        if s != 0 {
            if !returnString.isEmpty {
                returnString += ", "
            }
            returnString += "\(s) Seconds"
        }
//        return "\(h) Hours, \(m) Minutes, \(s) Seconds"
        return returnString
    }
    
    func secondsToHoursMinutesSecondsTople() -> (Int, Int, Int) {
        return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
}
