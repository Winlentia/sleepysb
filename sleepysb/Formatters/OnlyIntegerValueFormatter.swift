//
//  OnlyIntegerValueFormatter.swift
//  sleepysb
//
//  Created by Winlentia on 24.09.2023.
//

import Foundation

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
