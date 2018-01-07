//
//  NSString+WWExtension.m
//  ExEducation
//
//  Created by Tidus on 2017/5/30.
//  Copyright © 2017年 ExEdu. All rights reserved.
//

#import "NSString+WWExtension.h"

@implementation NSString (WWUrl)

#pragma mark - UrlEncoding
- (NSString *)ee_stringByUrlEncoding
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)self,  NULL,  (CFStringRef)@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ",  kCFStringEncodingUTF8));
    
    return result;
}

- (NSString *)ee_stringByAppendingParamWithName:(NSString *)name value:(NSString *)value
{
    name = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    value = [value ee_stringByUrlEncoding];
    
    NSString *url;
    if([self rangeOfString:@"?"].location == NSNotFound){
        url = [NSString stringWithFormat:@"%@?%@=%@", self, name, value];
    }else{
        url = [NSString stringWithFormat:@"%@&%@=%@", self, name, value];
    }
    return url;
}

- (BOOL)isEmpty
{
    if (!self || self.length == 0) {
        return YES;
    }else {
        return NO;
    }
    
}

- (BOOL)isBlank
{
    if ([self isEmpty]) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        if ([trimedString isEmpty]) {
            return true;
        } else {
            return false;
        }
    }
}

@end


@implementation NSMutableString (WWUrl)

- (void)ee_appendParamWithName:(NSString *)name value:(NSString *)value
{
    name = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    value = [value ee_stringByUrlEncoding];
    
    if([self rangeOfString:@"?"].location == NSNotFound){
        [self appendFormat:@"?%@=%@", name, value];
    }else{
        [self appendFormat:@"&%@=%@", name, value];
    }
}

@end
