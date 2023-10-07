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

        for item in AppStatusBarMenuItem.allCases {
            menu.addItem(AppMenuItem(appStatusBarItem: item))
        }
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        menuBarItem.menu = menu
    }
}

class AppMenuItem: NSMenuItem {
    
    let appStatusBarItem: AppStatusBarMenuItem
    
    init(appStatusBarItem: AppStatusBarMenuItem){
        self.appStatusBarItem = appStatusBarItem
        super.init(title: appStatusBarItem.title(), action: #selector(AppDelegate.menuItemSelector(_:)), keyEquivalent: appStatusBarItem.keyEquivalent())
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum AppStatusBarMenuItem: CaseIterable {
    case sleep15Min
    case sleep30Min
    case sleep45Min
    case sleep1Hour
}

extension AppStatusBarMenuItem {
    func title() -> String {
        switch self {
        case .sleep15Min:
            return "Sleep 15 Min"
        case .sleep30Min:
            return "Sleep 30 Min"
        case .sleep45Min:
            return "Sleep 45 Min"
        case .sleep1Hour:
            return "Sleep 1 Hour"
        }
    }
    
    func keyEquivalent() -> String {
        switch self {
        case .sleep15Min:
            return "1"
        case .sleep30Min:
            return "2"
        case .sleep45Min:
            return "3"
        case.sleep1Hour:
            return "4"
        }
    }
    
    func seconds() -> Int {
        switch self {
        case .sleep15Min:
            return 60*15
        case .sleep30Min:
            return 60*30
        case .sleep45Min:
            return 60*45
        case .sleep1Hour:
            return 60*60
        }
    }
}


