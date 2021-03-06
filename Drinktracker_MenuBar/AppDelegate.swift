//
//  AppDelegate.swift
//  Drinktracker_MenuBar
//
//  Created by Jeffrey Chen on 6/11/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import Cocoa
import SwiftUI

//popover things
//coredata?

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var popover: NSPopover!
    var statusBarItem: NSStatusItem!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
        
        // Create the popover
        let popover = NSPopover()
        
        popover.contentSize = NSSize(width: 400, height: 400)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover
        
            // Create the status item
            self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
            
            if let button = self.statusBarItem.button {
                //button.image = NSImage(named: "waterdrop2")
                button.title = "💧"
                button.action = #selector(togglePopover(_:))
            }
        }
        
        @objc func togglePopover(_ sender: AnyObject?) {
            //button control off of first click?
            //self.popover.contentViewController?.view.window?.becomeKey()
            if let button = self.statusBarItem.button {
                if self.popover.isShown {
                    self.popover.performClose(sender)
                } else {
                    self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                }
            }
        }
    
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
 
}
