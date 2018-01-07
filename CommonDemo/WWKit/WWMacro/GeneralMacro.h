//
//  GeneralMacro.h
//  ExEducation
//
//  Created by Tidus on 17/4/25.
//  Copyright © 2017年 ExEdu. All rights reserved.
//

#pragma mark - APP
/**
 *  APP相关
 */
#define APP_NAME            @"CommonDemo"//[[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey]
#define APP_DISPLAY_NAME    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_VERSION_PREFIX  [APP_VERSION substringToIndex:[APP_VERSION rangeOfString:@"."].location]
#define APP_USER_AGENT      [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)",\
                            APP_NAME ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey],\
                            [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey],\
                            [[UIDevice currentDevice] model],\
                            [[UIDevice currentDevice] systemVersion],\
                            [[UIScreen mainScreen] scale]]
#define APP_STORE_ID        0


#pragma mark - 系统
/**
 *  系统相关
 */
#define IOS_VERSION     ([[[UIDevice currentDevice] systemVersion] floatValue])
#define SCALE           ([UIScreen mainScreen].scale)
#define AUTO_SCALE      ([[UIScreen mainScreen] bounds].size.width / 375)


#pragma mark - code
#define WeakSelf \
        autoreleasepool {} \
        __weak typeof(self) weakSelf = self;




#pragma mark - 沙盒路径
/**
 *  /Document
 */
#define DOCUMENT_DIRECTORY          ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0])
/**
 *  /Document/FILE_STORAGE
 */
#define FILE_STORAGE_DIRECTORY      ([DOCUMENT_DIRECTORY stringByAppendingPathComponent:@"FILE_STORAGE"])
/**
 *  /Document/CONFIG_STORAGE
 */
#define CONFIG_STORAGE_DIRECTORY    ([CACHE_DIRECTORY stringByAppendingPathComponent:@"CONFIG_STORAGE"])

/**
 *  /Library
 */
#define LIBRARY_DIRECTORY           ([NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0])
/**
 *  /Library/Cache
 */
#define CACHE_DIRECTORY             ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0])


