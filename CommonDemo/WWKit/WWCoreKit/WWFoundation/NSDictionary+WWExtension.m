//
//  NSDictionary+WWExtension.m
//  ExEducation
//
//  Created by Tidus on 17/4/25.
//  Copyright © 2017年 ExEdu. All rights reserved.
//

#import <objc/runtime.h>
#import "NSDictionary+WWExtension.h"

#pragma mark - NSDictionary (WWStorage)
@implementation NSDictionary (WWStorage)

- (NSDictionary *)ee_initWithContentOfFileStorage:(NSString *)name
{
    [NSDictionary ensureFileStoragePath:FILE_STORAGE_DIRECTORY];
    NSString *storagePath = [FILE_STORAGE_DIRECTORY stringByAppendingPathComponent:name];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *dictionary;
    if([fileManager fileExistsAtPath:storagePath]){
        dictionary = [self initWithContentsOfFile:storagePath];
    }else{
        dictionary = [self init];
        [dictionary ee_writeToFileStorageWithName:name];
    }
    return dictionary;
}

- (BOOL)ee_writeToFileStorageWithName:(NSString *)name
{
    [NSDictionary ensureFileStoragePath:FILE_STORAGE_DIRECTORY];
    NSString *storagePath = [FILE_STORAGE_DIRECTORY stringByAppendingPathComponent:name];
    
    NSDictionary *dictForWrite = (NSDictionary *)[NSDictionary ensureNotNullContentForWrite:self];
    
    BOOL success = [dictForWrite writeToFile:storagePath atomically:NO];
    if(!success){
       NSLog(@"写入失败：%@", storagePath);
    }
    return success;
}

/**
 *  防止字典中含有空值导致写入失败
 */
+ (id)ensureNotNullContentForWrite:(id)object
{
    if(!object || [object isKindOfClass:[NSNull class]]){
        return @"";
    }
    
    if([object isKindOfClass:[NSString class]]){
        if ([object isEqualToString:@"<null>"]
            || [object isEqualToString:@"null"]
            || [object isEqualToString:@"(null)"]) {
            return @"";
        }
    }
    
    if([object isKindOfClass:[NSArray class]]){
        NSArray *array = (NSArray *)object;
        NSMutableArray *resultArray = [NSMutableArray array];
        for (id objInArray in array) {
            [resultArray addObject:[self ensureNotNullContentForWrite:objInArray]];
        }
        return resultArray;
    }
    
    if([object isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = (NSDictionary *)object;
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        for (NSString *key in dict.allKeys) {
            [resultDict setObject:[self ensureNotNullContentForWrite:[dict objectForKey:key]] forKey:key];
        }
        return resultDict;
    }

    //除空值、字符串、数组、字典外的其他类型直接返回
    return object;
}


+ (void)ensureFileStoragePath:(NSString *)path{
    static dispatch_once_t ensureFileStorage;
    dispatch_once(&ensureFileStorage, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = NO;
        if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
            return;
        }
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:true attributes:nil error:nil];
    });
}



@end

#pragma mark - NSDictionary (WWObject)
@implementation NSDictionary (WWObject)

- (NSString *)ee_stringForKey:(NSString *)key
{
    NSString *string = @"";
    id value = [self objectForKey:key];
    if(value){
        string = [NSString stringWithFormat:@"%@", value];
    }
    return string;
}
- (NSInteger)ee_integerForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if(value){
        return [value integerValue];
    }
    return 0;
}
- (CGFloat)ee_floatForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if(value){
        return [value floatValue];
    }
    return 0;
}
- (BOOL)ee_boolForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if(value){
        return [value boolValue];
    }
    return NO;
}

@end

#pragma mark - NSMutableDictionary (WWObject)
@implementation NSMutableDictionary (WWObject)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
        Method newMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(ee_setObject:forKey:));
        method_exchangeImplementations(oldMethod, newMethod);
    });
    
}

- (void)ee_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if(!anObject || !aKey){
#ifdef DEBUG
        NSString *msg = [NSString stringWithFormat:@"attemp insert %@ by %@ into dictionary",anObject ,aKey];
        NSAssert(NO, msg);
#endif
        return;
    }
    [self ee_setObject:anObject forKey:aKey];
}

@end
