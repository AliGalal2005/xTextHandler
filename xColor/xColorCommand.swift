//
//  ██╗  ██╗████████╗███████╗██╗  ██╗████████╗
//  ╚██╗██╔╝╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝
//   ╚███╔╝    ██║   █████╗   ╚███╔╝    ██║
//   ██╔██╗    ██║   ██╔══╝   ██╔██╗    ██║
//  ██╔╝ ██╗   ██║   ███████╗██╔╝ ██╗   ██║
//  ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝
//
//  xColorCommand.swift
//  xColor (https://github.com/cyanzhong/xTextHandler/)
//
//  Created by cyan on 16/7/4.
//  Copyright © 2016年 cyan. All rights reserved.
//

import Foundation
import XcodeKit

class xColorCommand: xTextCommand {
    
    override func handlers() -> Dictionary<String, xTextModifyHandler> {
        return [
            "xcolor.hex": { text -> String in HexColor(string: text) },
            "xcolor.rgb": { text -> String in RgbColor(string: text) },
            "xcolor.preview": { text -> String in PreviewColor(string: text) },
        ]
    }
    
    override func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: (NSError?) -> Void ) -> Void {
        let identifier = invocation.commandIdentifier
        if let handler = self.handlers()[identifier] {
            if identifier.hasSuffix("hex") {
                xTextModifier.rgb(invocation: invocation, handler: handler)
            } else if identifier.hasSuffix("rgb") {
                xTextModifier.hex(invocation: invocation, handler: handler)
            } else if identifier.hasSuffix("preview") {
                xTextModifier.any(invocation: invocation, handler: handler)
            }
        }
        completionHandler(nil)
    }
    
}
