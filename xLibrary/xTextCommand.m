//
//  xTextCommand.m
//  xTextHandler
//
//  Created by cyan on 16/6/20.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "xTextCommand.h"
#import "xTextModifier.h"

@implementation xTextCommand

+ (NSDictionary *)handlers {
    return nil;
}

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    [xTextModifier any:invocation handler:self.class.handlers[invocation.commandIdentifier]];
    completionHandler(nil);
}

@end
