//
//  TagModel.h
//  TidusWWDemo
//
//  Created by Tidus on 17/1/18.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagModel : NSObject

//文本
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;

//角度
@property (nonatomic, assign) CGFloat angle;

//文本位置
@property (nonatomic, assign) CGSize textSize;
@property (nonatomic, assign) CGPoint textPosition;

//初始化
- (instancetype)initWithName:(NSString *)name value:(NSString *)value;

@end
