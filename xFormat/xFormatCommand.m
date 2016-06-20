//
//  xFormatCommand.m
//  xFormat
//
//  Created by cyan on 16/6/19.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "xFormatCommand.h"
#import "xFormat.h"

@implementation xFormatCommand

- (NSDictionary *)handlers {
    static NSDictionary *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = @{
            @"xformat.json": ^NSString *(NSString *text) { return FormatJSON(text); },
        };
    });
    return _instance;
}

@end
