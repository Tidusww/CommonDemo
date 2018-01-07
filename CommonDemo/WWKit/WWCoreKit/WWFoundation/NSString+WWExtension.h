//
//  NSString+WWExtension.h
//  ExEducation
//
//  Created by Tidus on 2017/5/30.
//  Copyright © 2017年 ExEdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WWUrl)

/**
 *  UrlEncode
 */
- (NSString *)ee_stringByUrlEncoding;

/**
 *  在string后添加参数
 *  对参数的name部分进行百分号加密
 *  对参数的value部分进行url加密
 *  @param name redirect_路径
    @return value: http://member.zy.com/gotoAppLogin?pp=xx&isPptLogin=true
 */
- (NSString *)ee_stringByAppendingParamWithName:(NSString *)name value:(NSString *)value;

- (BOOL)isEmpty;
- (BOOL)isBlank;

@end

@interface NSMutableString (WWUrl)

- (void)ee_appendParamWithName:(NSString *)name value:(NSString *)value;

@end
