//
//  xTextModifier.h
//  xTextHandler
//
//  Created by cyan on 16/6/18.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <XcodeKit/XcodeKit.h>

typedef NSString * (^xTextHandlerBlock) (NSString *text);

@interface xTextModifier : NSObject

/// replace ///
+ (void)select:(XCSourceEditorCommandInvocation *)invocation pattern:(NSString *)pattern handler:(xTextHandlerBlock)handler;

+ (void)any:(XCSourceEditorCommandInvocation *)invocation handler:(xTextHandlerBlock)handler;

+ (void)radix:(XCSourceEditorCommandInvocation *)invocation handler:(xTextHandlerBlock)handler;

+ (void)hex:(XCSourceEditorCommandInvocation *)invocation handler:(xTextHandlerBlock)handler;
+ (void)rgb:(XCSourceEditorCommandInvocation *)invocation handler:(xTextHandlerBlock)handler;

@end
