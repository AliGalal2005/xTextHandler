//
//  xRadixCommand.swift
//  xRadix
//
//  Created by cyan on 16/7/4.
//  Copyright © 2016年 cyan. All rights reserved.
//

import Foundation
import XcodeKit

class xRadixCommand: xTextCommand {
    
    override func handlers() -> Dictionary<String, xTextModifyHandler> {
        return [
            "xradix.hex": { (text: String) -> (String) in Hex(string: text) },
            "xradix.bin": { (text: String) -> (String) in Bin(string: text) },
            "xradix.oct": { (text: String) -> (String) in Oct(string: text) },
            "xradix.dec": { (text: String) -> (String) in Dec(string: text) },
        ]
    }
 
    override func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: (NSError?) -> Void) {
        if let handler = self.handlers()[invocation.commandIdentifier] {
            xTextModifier.radix(invocation: invocation, handler: handler)
        }
        completionHandler(nil)
    }
}
