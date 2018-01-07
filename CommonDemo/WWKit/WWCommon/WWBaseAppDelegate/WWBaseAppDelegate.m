//
//  WWBaseAppDelegate.m
//  ExEducation
//
//  Created by Tidus on 17/4/27.
//  Copyright © 2017年 ExEdu. All rights reserved.
//

#import "WWBaseAppDelegate.h"

@implementation WWBaseAppDelegate

+ (instancetype)sharedAppDelegate
{
    return (WWBaseAppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark - life cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //初始化window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - Url处理
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options
{
    return YES;
}


#pragma mark - 通知
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}

#pragma mark - WWRouter相关
- (UITabBarController *)tabBarController
{
    UIWindow *window = self.window;
    UIViewController *root = window.rootViewController;
    if ([root isKindOfClass:[UITabBarController class]])
    {
        return (UITabBarController *)root;
    }
    
    return nil;
}

- (UINavigationController *)navigationViewController
{
    UIWindow *window = self.window;
    UIViewController *root = window.rootViewController;
    if ([root isKindOfClass:[UINavigationController class]])
    {
        return (UINavigationController *)root;
    }
    else if ([root isKindOfClass:[UITabBarController class]])
    {
        UIViewController *selectedViewController = [((UITabBarController *)root) selectedViewController];
        if ([selectedViewController isKindOfClass:[UINavigationController class]])
        {
            return (UINavigationController *)selectedViewController;
        }
    }
    return nil;
}
@end
