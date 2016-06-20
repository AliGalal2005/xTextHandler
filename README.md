# xTextHandler
Xcode Source Editor Extension Toolset

# What is it
[Xcode Source Editor Extension](https://developer.apple.com/videos/play/wwdc2016/414/) based tools, improve text editing for Xcode

# Features
- Multiline Selection
- Extendable API
- Regular Expression Matching

## xEncode
![image](https://raw.githubusercontent.com/cyanzhong/xTextHandler/master/GIFs/xEncode.gif)
- Base64 Encode
- Base64 Decode
- URL Encode
- URL Decode
- MD5
- Upper Case
- Lower Case
- Escape

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

## xFormat
![image](https://raw.githubusercontent.com/cyanzhong/xTextHandler/master/GIFs/xFormat.gif)
- JSON

# Usage
1. Install Xcode 8
2. Build & Run
3. Choose Xcode to debug
4. Select text
5. Open Editor menu to find extensions
6. You can set a shortcut for each extension

# How to write a new Extension
### Add definition in Plist:
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
### Implement handlers in class:
```objc
// implement your modify strategy using block (you can implement as singleton dict)
- (NSDictionary *)handlers {
    static NSDictionary *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = @{
            @"test.extension": ^NSString *(NSString *text) { return text; }
        };
    });
    return _instance;
}
```
### Handle with regex:
```objc
// override performCommandWithInvocation like that
- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    [xTextModifier select:invocation pattern:@"regex" handler:self.handlers[invocation.commandIdentifier]];
    completionHandler(nil);
}
```

# Tips
Xcode 8 Beta is completely unstable now, you may see nothing after you build this project
