//
//  xFormat.h
//  xTextHandler
//
//  Created by cyan on 16/6/19.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

static NSString *FormatJSON(NSString *string) {
    JSContext *context = [[JSContext alloc] init];
    JSValue *parse = context[@"JSON"][@"parse"];
    JSValue *stringify = context[@"JSON"][@"stringify"];
    JSValue *pretty = [stringify callWithArguments:@[
        [parse callWithArguments:@[string]],
        [JSValue valueWithNullInContext:context],
        @4 // indented 4 spaces
    ]];
    return pretty.isUndefined ? string : pretty.toString;
}
