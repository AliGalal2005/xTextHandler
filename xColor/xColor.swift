//
//  xColor.swift
//  xTextHandler (https://github.com/cyanzhong/xTextHandler/)
//
//  Created by cyan on 16/7/4.
//  Copyright © 2016年 cyan. All rights reserved.
//

import Foundation
import AppKit

func HexColor(string: String) -> String {
    
    let pattern = "([0-9]+).+?([0-9]+).+?([0-9]+)"
    var hex = ""
    
    do {
        let regex = try RegularExpression(pattern: pattern, options: .caseInsensitive)
        regex.enumerateMatches(in: string, options: RegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, string.characters.count), using: { result, flags, stop in
            
            let str = string as NSString
            if let range = result?.range(at: 1), r = Int(str.substring(with: range)) {
                hex += String(r, radix: 16)
            }
            
            if let range = result?.range(at: 2), g = Int(str.substring(with: range)) {
                hex += String(g, radix: 16)
            }
            
            if let range = result?.range(at: 3), b = Int(str.substring(with: range)) {
                hex += String(b, radix: 16)
            }
        })

    } catch {
        xTextLog(string: "Create regex failed")
    }
    
    return hex
}

func RgbColor(string: String) -> String {
    var rgbValue: UInt32 = 0
    let scanner = Scanner(string: string)
    scanner.scanHexInt32(&rgbValue)
    return String(format: "%d, %d, %d", ((rgbValue & 0xFF0000) >> 16), ((rgbValue & 0xFF00) >> 8), (rgbValue & 0xFF))
}

func PreviewColor(string: String) -> String {
    let predicate = Predicate(format: "SELF MATCHES %@", "[0-9a-fA-F]+")
    let value = predicate.evaluate(with: string) ? string : HexColor(string: string)
    NSWorkspace.shared().open(URL(string: "http://hexpreview.com/\(value)")!)
    return string
}
