//
//  WWBaseTabBarController.h
//  ExEducation
//
//  Created by Tidus on 17/4/27.
//  Copyright © 2017年 ExEdu. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kWWBaseTabBarControllerRootKey;


@interface WWBaseTabBarController : UITabBarController


- (instancetype)initWithConfig:(NSDictionary *)config;
- (void)setTabBarItemBadgeValue:(NSInteger)badgeValue itemIndex:(NSInteger)index;

@end


