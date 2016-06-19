//
//  xFormat.h
//  xTextHandler
//
//  Created by cyan on 16/6/19.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *FormatJSON(NSString *string) {

    NSError *error;
    NSString *object = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding]
                                                       options:NSJSONReadingMutableContainers
                                                         error:&error];
    
    if (error) {
        return string;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:object
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    
    if (error) {
        return string;
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ? : string;
}
