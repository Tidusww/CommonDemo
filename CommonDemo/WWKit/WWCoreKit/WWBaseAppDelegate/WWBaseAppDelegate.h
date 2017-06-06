//
//  WWBaseAppDelegate.h
//  TidusWWDemo
//
//  Created by Tidus on 17/2/23.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWRouter.h"

@interface WWBaseAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (UINavigationController *)navigationControllerForRoute;

@end
