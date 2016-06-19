//
//  xEncode.h
//  xTextHandler
//
//  Created by cyan on 16/6/18.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

static inline NSString *URLEncode(NSString *string) {
    return [string stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
}

static inline NSString *URLDecode(NSString *string) {
    return [string stringByRemovingPercentEncoding];
}

static inline NSString *Base64Encode(NSString *string) {
    NSData *encodedData = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [encodedData base64EncodedStringWithOptions:0];
}

static inline NSString *Base64Decode(NSString *string) {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:string options:0];
    return [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
}

static inline NSString *MD5(NSString *string) {
    const char *str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (uint32_t)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x", result[i]];
    }
    return ret;
}

static inline NSString *Uppercase(NSString *string) {
    return string.uppercaseString;
}

static inline NSString *Lowercase(NSString *string) {
    return string.lowercaseString;
}

static inline NSString *Escape(NSString *string) {
    NSMutableString *result = [NSMutableString string];
    NSUInteger length = [string length];
    for (NSUInteger i = 0; i < length; i++) {
        unichar uc = [string characterAtIndex:i];
        switch (uc) {
            case '\"': [result appendString:@"\\\""]; break;
            case '\'': [result appendString:@"\\\'"]; break;
            case '\\': [result appendString:@"\\\\"]; break;
            case '\t': [result appendString:@"\\t"]; break;
            case '\n': [result appendString:@"\\n"]; break;
            case '\r': [result appendString:@"\\r"]; break;
            case '\b': [result appendString:@"\\b"]; break;
            case '\f': [result appendString:@"\\f"]; break;
            default: {
                if (uc < 0x20) {
                    [result appendFormat:@"\\u%04x", uc];
                } else {
                    [result appendFormat:@"%C", uc];
                }
            } break;
        }
    }
    return result;
}
