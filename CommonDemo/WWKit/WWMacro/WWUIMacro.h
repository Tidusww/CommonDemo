//
//  WWUIMacro.h
//  TidusWWDemo
//
//  Created by Tidus on 16/9/7.
//  Copyright © 2016年 Tidus. All rights reserved.
//

/**
 *  UI相关
 */
#define Color(r,g,b,a)        ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])

#define STATUS_BAR_HEIGHT       ([UIApplication sharedApplication].statusBarFrame.size.height)
#define NAVIGATION_BAR_HEIGHT   (self.navigationController.navigationBar.frame.size.height)
#define TAB_BAR_HEIGHT          (self.tabBarController.tabBar.frame.size.height)

#define SCREEN_WIDTH             ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT            ([[UIScreen mainScreen] bounds].size.height)

#define APP_FRAME_WIDTH         ([UIScreen mainScreen].applicationFrame.size.width)
#define APP_FRAME_HEIGHT        ([UIScreen mainScreen].applicationFrame.size.height)
