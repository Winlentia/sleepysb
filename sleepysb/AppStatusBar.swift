//
//  AppStatusBar.swift
//  sleepysb
//
//  Created by Winlentia on 7.10.2023.
//

import Foundation
import Cocoa

class AppStatusBar {
    let menuBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    init() {
        if let button = menuBarItem.button {
            button.image = NSImage(named: "powersleep")
        }

        let menu = NSMenu()

        menu.addItem(NSMenuItem(title: "Print Quote", action: #selector(AppDelegate.menuItemSelector(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Quotes", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        menuBarItem.menu = menu
    }
}


