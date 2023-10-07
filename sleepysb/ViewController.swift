//
//  ViewController.swift
//  sleepysb
//
//  Created by Winlentia on 9.09.2023.
//

import Cocoa

class ViewController: NSViewController {
    
    let shellManager = ShellManager()
    let sleepTimerManager = SleepTimerManager.shared
    let predefinedSeconds: [Int] = [900,1800,2700,3600]
    
    @IBOutlet weak var stackPredefines: NSStackView!
    
    @IBOutlet weak var labelRemaining: NSTextField!
    @IBOutlet weak var textFieldSeconds: NSTextField!
    @IBOutlet weak var textFieldMinutes: NSTextField!
    @IBOutlet weak var textFieldHour: NSTextField!
    
    @IBOutlet weak var buttonStart: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sleepTimerManager.delegate = self
        setupTextFields()
        labelRemaining.stringValue = ""
        
        for sec in predefinedSeconds.reversed() {
            let button = PredefineActionButton()
            button.setupView(seconds: sec)
            button.action = #selector(predefineButtonAction(_:))
            stackPredefines.addArrangedSubview(button)
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    fileprivate func setupTextFields() {
        textFieldSeconds.delegate = self
        textFieldHour.delegate = self
        textFieldMinutes.delegate = self
        
        let onlyIntFormatter = OnlyIntegerValueFormatter()
        
        textFieldHour.formatter = onlyIntFormatter
        textFieldMinutes.formatter = onlyIntFormatter
        textFieldSeconds.formatter = onlyIntFormatter
        
        textFieldSeconds.stringValue = "0"
        textFieldMinutes.stringValue = "0"
        textFieldHour.stringValue = "0"
    }


    fileprivate func startAction() {
        let timeInSeconds = calculateTimerInSeconds()
        if timeInSeconds == 0 {
            return
        }
        sleepTimerManager.startAction(durationInSeconds: calculateTimerInSeconds()) {
            self.buttonStart.title = "Stop"
        }
    }
    
    fileprivate func stopAction() {
        sleepTimerManager.stopAction() {
            buttonStart.title = "Start"
            labelRemaining.stringValue = ""
        }
    }
    
    @IBAction func actionStart(_ sender: Any) {
        if sleepTimerManager.isTimerActive() {
            stopAction()
        } else {
            startAction()
        }
    }
    
    @objc func predefineButtonAction(_ sender: Any) {
        let button = sender as? PredefineActionButton
        if let (h, m, s) = button?.seconds?.secondsToHoursMinutesSecondsTople() {
            textFieldHour.stringValue = "\(h)"
            textFieldMinutes.stringValue = "\(m)"
            textFieldSeconds.stringValue = "\(s)"
        }
    }
    
    func calculateTimerInSeconds() -> Int {
        let seconds = Int(textFieldSeconds.stringValue) ?? 0
        let minutes = (Int(textFieldMinutes.stringValue) ?? 0) * 60
        let hours = (Int(textFieldHour.stringValue) ?? 0) * 60 * 60
        return seconds + minutes + hours
    }
}


extension ViewController: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        let textField = obj.object as? NSTextField
        if textField === textFieldHour {
            print("textFieldHour \(textFieldHour.stringValue)")
        } else if textField === textFieldMinutes {
            print("textFieldHour \(textFieldMinutes.stringValue)")
        } else if textField === textFieldSeconds {
            print("textFieldHour \(textFieldSeconds.stringValue)")
        }
    }
}

extension ViewController: SleepTimerManagerDelegate {
    func timerFired(remainingDurationInSeconds: Int?, remainingDurationTitle: String?) {
        if let title = remainingDurationTitle {
            self.labelRemaining.stringValue =  title
        }
    }
    
    func timerStarted() {
        self.buttonStart.title = "Stop"
    }
    
    func timerCompleted() {
        buttonStart.title = "Start"
        labelRemaining.stringValue = ""
    }
    
    
}

