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

static inline unsigned int BytesLength(NSString *string) {
    return (unsigned int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
}

static inline NSString *toHex(unsigned char *data, unsigned int length) {
    NSMutableString *hash = [NSMutableString stringWithCapacity:length * 2];
    for (int i = 0; i < length; i++) {
        [hash appendFormat:@"%02x", data[i]];
        data[i] = 0;
    }
    return hash;
}

static inline NSString *MD5(NSString *string) {
    unsigned int length = CC_MD5_DIGEST_LENGTH;
    unsigned char output[length];
    CC_MD5(string.UTF8String, BytesLength(string), output);
    return toHex(output, length);
}

static inline NSString *SHA1(NSString *string) {
    unsigned int length = CC_SHA1_DIGEST_LENGTH;
    unsigned char output[length];
    CC_SHA1(string.UTF8String, BytesLength(string), output);
    return toHex(output, length);
}

static inline NSString *SHA256(NSString *string) {
    unsigned int length = CC_SHA256_DIGEST_LENGTH;
    unsigned char output[length];
    CC_SHA256(string.UTF8String, BytesLength(string), output);
    return toHex(output, length);
}
