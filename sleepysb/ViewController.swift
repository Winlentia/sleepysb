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

    @IBOutlet weak var textFieldSeconds: NSTextField!
    @IBOutlet weak var textFieldMinutes: NSTextField!
    @IBOutlet weak var textFieldHour: NSTextField!
    
    @IBOutlet weak var buttonStart: NSButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
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


    @IBAction func actionStart(_ sender: Any) {
        isTimerActive = !isTimerActive
        
        if isTimerActive {
            buttonStart.title = "Stop"
            print(calculateTimerInSeconds())
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        } else {
            buttonStart.title = "Start"
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc func fireTimer() {
        print("Timer fired!")
    }
    
    func calculateTimerInSeconds() -> Int {
//        return (textFieldSeconds.intValue) + (textFieldMinutes.intValue * 60) + (textFieldHour.intValue * 60 * 60)
//        return Int(textFieldSeconds.stringValue) + Int(text)
        let seconds = Int(textFieldSeconds.stringValue) ?? 0
        let minutes = (Int(textFieldMinutes.stringValue) ?? 0) * 60
        let hours = (Int(textFieldHour.stringValue) ?? 0) * 60 * 60
        return seconds + minutes + hours
    }
    
    let deadlineMinutes = DispatchTime.now() + 60*1.0
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

class OnlyIntegerValueFormatter: NumberFormatter {
    
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        // Ability to reset your field (otherwise you can't delete the content)
        // You can check if the field is empty later
        if partialString.isEmpty {
            return true
        }
        
        // Optional: limit input length
        if partialString.count > 2 {
            return false
        }
        
        // Actual check
        return Int(partialString) != nil
    }
}
