//
//  xFormat.swift
//  xTextHandler (https://github.com/cyanzhong/xTextHandler/)
//
//  Created by cyan on 16/7/4.
//  Copyright © 2016年 cyan. All rights reserved.
//

//  Thanks to: https://github.com/vkiryukhin/vkBeautify
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Vadim Kiryukhin
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

import Foundation
import AppKit
import JavaScriptCore

let xFormatIndentationWidth = 2

func vkBeautify(string: String, type: String) -> String {
    
    let context = JSContext()!
    if let path = Bundle.main.pathForResource("vkbeautify", ofType: "js") {
        do {
            let js = try String(contentsOfFile: path, encoding: .utf8)
            context.evaluateScript(js)
        } catch {
            xTextLog(string: "Load vkbeautify failed")
        }
    }

    if let parser = context.objectForKeyedSubscript("parser").objectForKeyedSubscript(type), pretty = parser.call(withArguments: [ string, xFormatIndentationWidth ]) {
        return pretty.isUndefined ? string : pretty.toString()
    }
    
    return string
}
