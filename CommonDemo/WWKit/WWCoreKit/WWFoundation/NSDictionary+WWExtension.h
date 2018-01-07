//
//  NSDictionary+WWExtension.h
//  ExEducation
//
//  Created by Tidus on 17/4/25.
//  Copyright © 2017年 ExEdu. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - WWStorage
@interface NSDictionary (WWStorage)

- (NSDictionary *)ee_initWithContentOfFileStorage:(NSString *)name;
- (BOOL)ee_writeToFileStorageWithName:(NSString *)name;

@end


@interface NSDictionary (WWObject)

- (NSString *)ee_stringForKey:(NSString *)key;
- (NSInteger)ee_integerForKey:(NSString *)key;
- (CGFloat)ee_floatForKey:(NSString *)key;
- (BOOL)ee_boolForKey:(NSString *)key;

@end


@interface NSMutableDictionary (WWObject)


@end
