//
//  ViewController.swift
//  sleepysb
//
//  Created by Winlentia on 9.09.2023.
//

import Cocoa

class ViewController: NSViewController {
    
    let shellManager = ShellManager()
    var isTimerActive: Bool = false
    var timer: Timer? = nil
    let predefinedSeconds: [Int] = [60,900,1800,2700,3600]
    
    @IBOutlet weak var stackPredefines: NSStackView!
    var durationInSeconds: Int?
    var remainingSeconds: Int?
    
    @IBOutlet weak var labelRemaining: NSTextField!
    
    @IBOutlet weak var textFieldSeconds: NSTextField!
    @IBOutlet weak var textFieldMinutes: NSTextField!
    @IBOutlet weak var textFieldHour: NSTextField!
    
    @IBOutlet weak var buttonStart: NSButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
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


    fileprivate func startAction(isUserTriggers: Bool = true) {
        if !isUserTriggers {
            isTimerActive = !isTimerActive
        }
        buttonStart.title = "Stop"
        durationInSeconds = calculateTimerInSeconds()
        remainingSeconds = calculateTimerInSeconds()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    

    
    fileprivate func stopAction(isUserTriggers: Bool = true) {
        if !isUserTriggers {
            isTimerActive = !isTimerActive
        }
        buttonStart.title = "Start"
        labelRemaining.stringValue = ""
        invalidateTimer()
    }
    
    @IBAction func actionStart(_ sender: Any) {
        isTimerActive = !isTimerActive
        if isTimerActive {
            startAction()
        } else {
            stopAction()
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
    
    @objc func fireTimer() {
        guard let remainingSeconds = remainingSeconds else {
            invalidateTimer()
            return
        }
        
        self.remainingSeconds! = self.remainingSeconds! - 1
        self.labelRemaining.stringValue = self.remainingSeconds!.secondsToHoursMinutesSecondsString()
        
        if remainingSeconds == 0 {
            invalidateTimer()
            shellManager.sleepMac()
            stopAction(isUserTriggers: false)
        }
    }
    
    func calculateTimerInSeconds() -> Int {
        let seconds = Int(textFieldSeconds.stringValue) ?? 0
        let minutes = (Int(textFieldMinutes.stringValue) ?? 0) * 60
        let hours = (Int(textFieldHour.stringValue) ?? 0) * 60 * 60
        return seconds + minutes + hours
    }
    
    fileprivate func invalidateTimer() {
        timer?.invalidate()
        timer = nil
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


