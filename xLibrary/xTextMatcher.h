//
//  xTextMatcher.h
//  xTextHandler
//
//  Created by cyan on 16/6/18.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <XcodeKit/XcodeKit.h>

static NSString *const xTextHandlerAnyPattern       = @"*";
static NSString *const xTextHandlerStringPattern    = @"\"(.+)\"";
static NSString *const xTextHandlerHexPattern       = @"([0-9a-fA-F]+)";
static NSString *const xTextHandlerRGBPattern       = @"([0-9]+.+[0-9]+.+[0-9]+)";
static NSString *const xTextHandlerRadixPattern     = @"([0-9]+)";

@interface xTextMatchResult : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSRange range;

@end

@interface xTextMatcher : NSObject

+ (xTextMatchResult *)match:(XCSourceTextRange *)selection invocation:(XCSourceEditorCommandInvocation *)invocation;

@end
