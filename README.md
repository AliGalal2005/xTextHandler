# Download
<a href="https://itunes.apple.com/app/id1163761963">![](https://cdn.rawgit.com/cyanzhong/xTextHandler/master/mas.svg)</a>

# Let's Swift!
[![Language](https://img.shields.io/badge/language-Swift%203.0-orange.svg)](https://swift.org/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/cyanzhong/xTextHandler/blob/master/LICENSE)

`xTextHandler` has been rewritten in `Swift`. The `Objective-C` version can be found in: https://github.com/cyanzhong/xTextHandler-objc

🇨🇳[中文介绍](https://github.com/cyanzhong/xTextHandler/blob/master/README_CN.md)

# xTextHandler
Xcode Source Editor Extension Tools (Xcode 8 Plugins)

# What is it
[Xcode Source Editor Extension](https://developer.apple.com/videos/play/wwdc2016/414/) based tools to improve the text editing experience of `Xcode 8` and provide extensions with simple code.

# Features
- [x] Multiline Selections
- [x] Multiple Extensions
- [x] Extendable (Example: [Dotify](https://github.com/cyanzhong/Dotify))
- [x] Swift 3.0
- [x] Clipboard Text Handling (if no selection is made)
- [x] Regular Expression Matching
- [ ] Error handling
- [ ] Preferences panel
- [ ] JavaScript for text handling

# Install from Mac App Store
0. Clear DrivedData if you built xTextHandler before
1. Install from: https://itunes.apple.com/app/id1163761963
2. Open Xcode and select text
3. Open `Editor` menu to find extensions
4. You can set a shortcut (`Key-Binding`) for each extension
5. If you got nothing after installed, it must be a bug of XcodeKit, you can try build this project

# Build
0. Install `Xcode 8`
1. `sudo /usr/libexec/xpccachectl` in `macOS EI Capitan`
2. Sign every targets (app & extensions) using your developer certificate
3. Build & Run
4. Choose `Xcode 8` to debug (Or restart Xcode)
5. Select text
6. Open `Editor` menu to find extensions
7. You can set a shortcut (`Key-Binding`) for each extension

## xEncode
![image](https://raw.githubusercontent.com/cyanzhong/xTextHandler/master/GIFs/xEncode.gif)
- Base64 Encode
- Base64 Decode
- URL Encode
- URL Decode
- Upper Case
- Lower Case
- Escape
- MD5
- SHA1
- SHA256
- QR Code

## xRadix
![image](https://raw.githubusercontent.com/cyanzhong/xTextHandler/master/GIFs/xRadix.gif)
- Hex
- Bin
- Oct
- Dec

## xColor
![image](https://raw.githubusercontent.com/cyanzhong/xTextHandler/master/GIFs/xColor.gif)
- Hex
- RGB
- Preview

## xSearch
![image](https://raw.githubusercontent.com/cyanzhong/xTextHandler/master/GIFs/xSearch.gif)
- Google
- Translate
- Developer
- StackOverflow
- GitHub
- Dash
- Dictionary

## xFormat
![image](https://raw.githubusercontent.com/cyanzhong/xTextHandler/master/GIFs/xFormat.gif)
- JSON
- XML
- CSS
- SQL

Thanks to: [`vkBeautify`](https://github.com/vkiryukhin/vkBeautify)

# How to write a new Extension
### Add definition in `Plist`:
```xml
<dict>
    <key>XCSourceEditorCommandClassName</key>
    <string>aClassName</string>
    <key>XCSourceEditorCommandIdentifier</key>
    <string>test.extension</string>
    <key>XCSourceEditorCommandName</key>
    <string>Test Extension</string>
</dict>
```
### Map `handler` via `commandIdentifier` in class:
```swift
// Implement your modify strategy using block (you can implement as singleton dict)
// [ "commandIdentifier": handler ]
override func handlers() -> Dictionary<String, xTextModifyHandler> {
    return [
        "test.extension": { text: String -> String in text }
    ]
}
```
### * Handle with `regex`:
```swift
// Override performCommandWithInvocation like that
override func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: (NSError?) -> Void) {
    if let handler = self.handlers()[invocation.commandIdentifier] {
        xTextModifier.select(invocation: invocation, pattern: "regex", handler: handler)
    }
    completionHandler(nil)
}
```

# Contacts
[![Weibo](https://img.shields.io/badge/weibo-%20@StackOverflowError%20-red.svg)](http://weibo.com/0x00eeee/)
[![Twitter](https://img.shields.io/badge/twitter-@cyanapps-green.svg)](https://twitter.com/cyanapps)
[![Email](https://img.shields.io/badge/email-log.e@qq.com-blue.svg)](mailto:log.e@qq.com)
