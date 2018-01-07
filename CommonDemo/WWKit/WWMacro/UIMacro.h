//
//  UIMacro.h
//  TidusWWDemo
//
//  Created by Tidus on 16/9/7.
//  Copyright © 2016年 Tidus. All rights reserved.
//

/**
 *  UI相关
 */
#define STATUS_BAR_HEIGHT       ([UIApplication sharedApplication].statusBarFrame.size.height)
#define NAVIGATION_BAR_HEIGHT   ([WWRouter topNavigationController].navigationBar.frame.size.height)
#define TAB_BAR_HEIGHT          ([WWRouter rootTabBarController].tabBar.frame.size.height)

#define SCREEN_WIDTH            ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT           ([[UIScreen mainScreen] bounds].size.height)

#define APP_FRAME_WIDTH         ([UIScreen mainScreen].applicationFrame.size.width)
#define APP_FRAME_HEIGHT        ([UIScreen mainScreen].applicationFrame.size.height)



#pragma mark - 颜色
/**
 *  颜色相关
 */
#define Color(r,g,b,a)          ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
//APP背景颜色
#define APP_BG_COLOR            Color(245, 245, 245, 1)
//APP主题色
#define APP_THEME_COLOR         Color(91, 162, 243, 1)
//WebView加载条颜色
#define WEB_LOADING_COLOR       Color(255, 189, 44, 1)

//TabBar主题色
#define TAB_BAR_TINT_COLOR      Color(248, 248, 255, 1)
#define TAB_BAR_SELECTED_COLOR  Color(18, 150, 219, 1)
#define TAB_BAR_UNSELECT_COLOR  Color(230, 230, 230, 1)
