//
//  SleepTimerManager.swift
//  sleepysb
//
//  Created by Winlentia on 8.10.2023.
//

import Foundation

protocol SleepTimerManagerDelegate {
    func timerFired(remainingDurationInSeconds: Int?, remainingDurationTitle: String?)
    func timerStarted()
    func timerCompleted()
}

class SleepTimerManager {
    static let shared = SleepTimerManager()
    var delegate: SleepTimerManagerDelegate?
    
    let shellManager = ShellManager()
    
    var timer: Timer? = nil
    
    var durationInSeconds: Int?
    var remainingSeconds: Int?
    
    func startAction(durationInSeconds: Int, completion: () -> ()) {
        invalidateTimer()
        self.durationInSeconds = durationInSeconds
        remainingSeconds = durationInSeconds
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        delegate?.timerStarted()
        completion()
    }
    
    func stopAction(completion: () -> ()) {
        invalidateTimer()
        completion()
    }
    
    
    @objc func fireTimer() {
        guard let remainingSeconds = remainingSeconds else {
            invalidateTimer()
            return
        }
        
        self.remainingSeconds! = self.remainingSeconds! - 1
        delegate?.timerFired(remainingDurationInSeconds: remainingSeconds, remainingDurationTitle: remainingSeconds.secondsToHoursMinutesSecondsString())
        
        if remainingSeconds == 0 {
            invalidateTimer()
            delegate?.timerCompleted()
            shellManager.sleepMac()
            stopAction(completion: {})
        }
    }
    
    fileprivate func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func isTimerActive() -> Bool {
        return timer == nil ? false : true
    }
}


class TestSleepManager {
    let sleepManager = SleepTimerManager.shared
    
    init() {
        sleepManager.startAction(durationInSeconds: 5, completion: {})
    }
}
