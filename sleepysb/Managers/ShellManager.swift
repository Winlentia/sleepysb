//
//  ShellManager.swift
//  sleepysb
//
//  Created by Winlentia on 23.09.2023.
//

import Foundation

class ShellManager {
    
    func sleepMac(){
        do {
            try safeShell("pmset sleepnow")
        } catch {
            print("\(error)")
        }
    }
    
    @discardableResult // Add to suppress warnings when you don't want/need a result
    private func safeShell(_ command: String) throws -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/bash")
        task.standardInput = nil

        try task.run() //<--updated
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        return output
    }
    
    @discardableResult
    private func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.executableURL = URL(fileURLWithPath: "/bin/bash")
        task.waitUntilExit()
        return task.terminationStatus
    }
}
