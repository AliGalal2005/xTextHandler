//
//  xEncodeCommand.swift
//  xEncode
//
//  Created by cyan on 16/7/4.
//  Copyright © 2016年 cyan. All rights reserved.
//

import Foundation

class xEncodeCommand: xTextCommand {
    override func handlers() -> Dictionary<String, xTextModifyHandler> {
        return [
            "xencode.base64encode": { (text: String) -> (String) in Base64Encode(string: text) },
            "xencode.base64decode": { (text: String) -> (String) in Base64Decode(string: text) },
            "xencode.urlencode": { (text: String) -> (String) in URLEncode(string: text) },
            "xencode.urldecode": { (text: String) -> (String) in URLDecode(string: text) },
            "xencode.uppercase": { (text: String) -> (String) in UpperCase(string: text) },
            "xencode.lowercase": { (text: String) -> (String) in LowerCase(string: text) },
            "xencode.escape": { (text: String) -> (String) in Escape(string: text) },
            "xencode.md5": { (text: String) -> (String) in MD5(string: text) },
            "xencode.sha1": { (text: String) -> (String) in SHA1(string: text) },
            "xencode.sha256": { (text: String) -> (String) in SHA256(string: text) },
            "xencode.qrcode": { (text: String) -> (String) in QRCode(string: text) },
        ]
    }
}
