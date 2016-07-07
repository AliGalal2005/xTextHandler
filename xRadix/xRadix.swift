//
//  xRadix.swift
//  xTextHandler (https://github.com/cyanzhong/xTextHandler/)
//
//  Created by cyan on 16/7/4.
//  Copyright © 2016年 cyan. All rights reserved.
//

import Foundation

func Hex(string: String) -> String {
    if let dec = Int(Dec(string: string)) {
        return String(dec, radix: 16)
    } else {
        return string
    }
}

func Bin(string: String) -> String {
    if let dec = Int(Dec(string: string)) {
        return String(dec, radix: 2)
    } else {
        return string
    }
}

func Oct(string: String) -> String {
    if let dec = Int(Dec(string: string)) {
        return String(dec, radix: 8)
    } else {
        return string
    }
}

func RadixConvert(string: String, offset: Int, radix: Int) -> String {
    if let number = Int(string.substring(from: string.index(string.startIndex, offsetBy: offset)), radix: radix) {
        return String(number)
    } else {
        return string
    }
}

func Dec(string: String) -> String {
    if string.hasPrefix("#") {
        return RadixConvert(string: string, offset: 1, radix: 16)
    } else if string.hasPrefix("0x") {
        return RadixConvert(string: string, offset: 2, radix: 16)
    } else if string.hasPrefix("0o") {
        return RadixConvert(string: string, offset: 2, radix: 8)
    } else if string.hasPrefix("0b") {
        return RadixConvert(string: string, offset: 2, radix: 2)
    } else {
        return string
    }
}
