//
//  AppDelegate.swift
//  sleepysb
//
//  Created by Winlentia on 9.09.2023.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var appStatusBar: AppStatusBar!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        appStatusBar = AppStatusBar()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    @objc func menuItemSelector(_ sender: Any?) {
        guard let menuItem = sender as? NSMenuItem else { return }
        
        if menuItem.title == "Print Quote" {
            print("Print Quote")
        }
    }
}

