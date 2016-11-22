//
//  ██╗  ██╗████████╗███████╗██╗  ██╗████████╗
//  ╚██╗██╔╝╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝
//   ╚███╔╝    ██║   █████╗   ╚███╔╝    ██║
//   ██╔██╗    ██║   ██╔══╝   ██╔██╗    ██║
//  ██╔╝ ██╗   ██║   ███████╗██╔╝ ██╗   ██║
//  ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝
//
//  AppViewController.swift
//  xTextHandler (https://github.com/cyanzhong/xTextHandler/)
//
//  Created by cyan on 16/7/4.
//  Copyright © 2016年 cyan. All rights reserved.
//

import Cocoa

class AppViewController: NSViewController {
  
  func open(_ string: String) {
    if let url = URL(string: string) {
      NSWorkspace.shared().open(url)
    }
  }
  
  @IBAction func usage(_ sender: AnyObject) {
    open("https://github.com/cyanzhong/xTextHandler/")
  }
  
  @IBAction func basic(_ sender: AnyObject) {
    open("https://developer.apple.com/xcode/")
  }
  
  @IBAction func session(_ sender: AnyObject) {
    open("https://developer.apple.com/videos/play/wwdc2016/414/")
  }
  
  @IBAction func preferences(_ sender: AnyObject) {
    open(URL(fileURLWithPath: "/System/Library/PreferencePanes/Extensions.prefPane").absoluteString)
  }
}

