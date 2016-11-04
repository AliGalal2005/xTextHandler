//
//  ██╗  ██╗████████╗███████╗██╗  ██╗████████╗
//  ╚██╗██╔╝╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝
//   ╚███╔╝    ██║   █████╗   ╚███╔╝    ██║
//   ██╔██╗    ██║   ██╔══╝   ██╔██╗    ██║
//  ██╔╝ ██╗   ██║   ███████╗██╔╝ ██╗   ██║
//  ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝
//
//  xEncodeCommand.swift
//  xEncode (https://github.com/cyanzhong/xTextHandler/)
//
//  Created by cyan on 16/7/4.
//  Copyright © 2016年 cyan. All rights reserved.
//

import Foundation

class xEncodeCommand: xTextCommand {
  override func handlers() -> Dictionary<String, xTextModifyHandler> {
    return [
      "xencode.base64encode": { text -> String in Base64Encode(string: text) },
      "xencode.base64decode": { text -> String in Base64Decode(string: text) },
      "xencode.urlencode": { text -> String in URLEncode(string: text) },
      "xencode.urldecode": { text -> String in URLDecode(string: text) },
      "xencode.uppercase": { text -> String in UpperCase(string: text) },
      "xencode.lowercase": { text -> String in LowerCase(string: text) },
      "xencode.escape": { text -> String in Escape(string: text) },
      "xencode.md5": { text -> String in MD5(string: text) },
      "xencode.sha1": { text -> String in SHA1(string: text) },
      "xencode.sha256": { text -> String in SHA256(string: text) },
      "xencode.qrcode": { text -> String in QRCode(string: text) },
    ]
  }
}
