//
//  AppWindowController.swift
//  xTextHandler
//
//  Created by cyan on 2016/10/10.
//  Copyright © 2016年 cyan. All rights reserved.
//

import Cocoa

class AppWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
    }
}
