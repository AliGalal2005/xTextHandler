//
//  xSearch.swift
//  xTextHandler (https://github.com/cyanzhong/xTextHandler/)
//
//  Created by cyan on 16/7/4.
//  Copyright © 2016年 cyan. All rights reserved.
//

import Foundation
import AppKit

let Engines = [
    "google": "https://www.google.com/#newwindow=1&q=",
    "developer": "https://developer.apple.com/search/?q=",
    "translate": "http://translate.google.cn/?hl=en#en/zh-CN/",
    "stackoverflow": "http://stackoverflow.com/search?q=",
    "github": "https://github.com/search?q=",
    "dash": "dash://",
]

func Search(string: String, type: String) -> String {
    if let keyword = string.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
        let url = Engines[type]! + keyword
        NSWorkspace.shared().open(URL(string: url)!)
    }
    return string
}

func PerformService(string: String, name: String) -> String {
    let pasteboard = NSPasteboard.general()
    pasteboard.declareTypes([NSPasteboardTypeString], owner: nil)
    pasteboard.setString(string, forType: NSPasteboardTypeString)
    NSPerformService(name, pasteboard)
    return string
}
