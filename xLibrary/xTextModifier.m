//
//  xTextModifier.m
//  xTextHandler
//
//  Created by cyan on 16/6/18.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "xTextModifier.h"
#import "xTextMatcher.h"

@implementation xTextModifier

+ (void)select:(XCSourceEditorCommandInvocation *)invocation pattern:(NSString *)pattern handler:(xTextHandlerBlock)handler {
    
    NSRegularExpression *regex;
    if (![pattern isEqualToString:xTextHandlerAnyPattern]) {
        regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                          options:0
                                                            error:nil];
    }

    // enumerate selections
    for (XCSourceTextRange *range in invocation.buffer.selections) {
        
        // match clipped text
        xTextMatchResult *match = [xTextMatcher match:range invocation:invocation];
        NSMutableArray<NSString *> *texts = [NSMutableArray array];
        
        if (regex) { // match using regex
            [regex enumerateMatchesInString:match.text options:0 range:match.range usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                [texts addObject:[match.text substringWithRange:[result rangeAtIndex:1]]];
            }];
        } else { // match all
            [texts addObject:[match.text substringWithRange:match.range]];
        }
        
        if (texts.count == 0) { // filter empty case
            continue;
        }
        
        NSMutableString *replace = match.text.mutableCopy;
        for (NSString *text in texts) {
            // replace each matched text with handler block
            [replace replaceOccurrencesOfString:text withString:handler(text) options:0 range:NSMakeRange(0, replace.length)];
        }
        
        // separate text to lines using newline charset
        NSArray<NSString *> *lines = [replace componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        // update buffer
        [invocation.buffer.lines replaceObjectsInRange:NSMakeRange(range.start.line, range.end.line-range.start.line+1)
                                  withObjectsFromArray:lines];
        
        range.end = range.start; // cancel selection
    }
}

+ (void)any:(XCSourceEditorCommandInvocation *)invocation handler:(xTextHandlerBlock)handler {
    [self select:invocation pattern:xTextHandlerAnyPattern handler:handler];
}

+ (void)radix:(XCSourceEditorCommandInvocation *)invocation handler:(xTextHandlerBlock)handler {
    [self select:invocation pattern:xTextHandlerRadixPattern handler:handler];
}

+ (void)hex:(XCSourceEditorCommandInvocation *)invocation handler:(xTextHandlerBlock)handler {
    [self select:invocation pattern:xTextHandlerHexPattern handler:handler];
}

+ (void)rgb:(XCSourceEditorCommandInvocation *)invocation handler:(xTextHandlerBlock)handler {
    [self select:invocation pattern:xTextHandlerRGBPattern handler:handler];
}

@end
