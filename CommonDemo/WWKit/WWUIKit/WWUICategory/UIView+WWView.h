//
//  UIView+WWView.h
//  TidusWWDemo
//
//  Created by Tidus on 16/9/7.
//  Copyright © 2016年 Tidus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WWView)

#pragma mark - Frame

- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)width;
- (CGFloat)height;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

@end
