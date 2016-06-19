//
//  xTextProtocol.h
//  xTextHandler
//
//  Created by cyan on 16/6/18.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <XcodeKit/XcodeKit.h>

@protocol xTextProtocol <NSObject, XCSourceEditorCommand>

+ (NSDictionary *)handlers;

@end
