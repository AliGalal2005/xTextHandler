//
//  ██╗  ██╗████████╗███████╗██╗  ██╗████████╗
//  ╚██╗██╔╝╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝
//   ╚███╔╝    ██║   █████╗   ╚███╔╝    ██║
//   ██╔██╗    ██║   ██╔══╝   ██╔██╗    ██║
//  ██╔╝ ██╗   ██║   ███████╗██╔╝ ██╗   ██║
//  ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝
//
//  xSearchCommand.swift
//  xSearch (https://github.com/cyanzhong/xTextHandler/)
//
//  Created by cyan on 16/7/4.
//  Copyright © 2016年 cyan. All rights reserved.
//

import Foundation

class xSearchCommand: xTextCommand {
    override func handlers() -> Dictionary<String, xTextModifyHandler> {
        return [
            "xsearch.google": { text -> String in Search(string: text, type: "google") },
            "xsearch.developer": { text -> String in Search(string: text, type: "developer") },
            "xsearch.translate": { text -> String in Search(string: text, type: "translate") },
            "xsearch.stackoverflow": { text -> String in Search(string: text, type: "stackoverflow") },
            "xsearch.github": { text -> String in Search(string: text, type: "github") },
            "xsearch.dash": { text -> String in Search(string: text, type: "dash") },
            "xsearch.dict": { text -> String in PerformService(string: text, name: "Look Up in Dictionary") },
        ]
    }
}
