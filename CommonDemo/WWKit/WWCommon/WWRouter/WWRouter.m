//
//  WWRouter.m
//  ExEducation
//
//  Created by Tidus on 17/4/14.
//  Copyright © 2017年 ExEdu. All rights reserved.
//

#import "WWRouter.h"


NSString* const kWWRouterPList = @"WWRouter";
static NSDictionary *urlMap = nil;


@implementation WWRouter

#pragma mark - life cycle
+ (void)load
{
    static WWRouter *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[WWRouter alloc] init];
        NSString *urlPath = [[NSBundle mainBundle] pathForResource:kWWRouterPList ofType:@".plist"];
        if(urlPath.length != 0){
            urlMap = [NSDictionary dictionaryWithContentsOfFile:urlPath];
        }
    });
}

+ (UIViewController *)viewControllerForUrl:(NSString *)url param:(NSDictionary *)param
{
    if(url.length == 0){
        NSLog(@"%s : url is nil", __func__);
        return nil;
    }
    
    NSString *className = [urlMap objectForKey:url];
    if(className.length == 0){
        NSLog(@"%s : className is nil for url:%@", __func__, url);
        return nil;
    }
    
    Class aClass = NSClassFromString(className);
    if(aClass && [aClass conformsToProtocol:@protocol(WWRouterProtocol)]){
        UIViewController *viewController = [[aClass alloc] initForRouterWithUrl:url param:param];
        if(viewController){
            return viewController;
        }else{
            NSLog(@"viewController %@ 初始化失败。", className);
        }
    }else{
        NSString *desc = [NSString stringWithFormat:@"%@ 必须实现 @WWRouterProtocol 协议。", className];
        NSAssert(NO, desc);
    }
    return nil;
}

#pragma mark - <#mark#>
+ (UITabBarController *)rootTabBarController
{
    WWBaseAppDelegate *delegate = [WWBaseAppDelegate sharedAppDelegate];
    UITabBarController *tabBarController = [delegate tabBarController];
    return tabBarController;
}

+ (UINavigationController *)topNavigationController
{
    WWBaseAppDelegate *delegate = [WWBaseAppDelegate sharedAppDelegate];
    UINavigationController *navigationController = [delegate navigationViewController];
    return navigationController;
}


#pragma mark - route
+ (void)routeToUrl:(NSString *)url
{
    [self routeToUrl:url param:nil];
}

+ (void)routeToUrl:(NSString *)url param:(NSDictionary *)param
{
    UINavigationController *navigationController = [self topNavigationController];
    UIViewController *viewController = [self viewControllerForUrl:url param:param];
    
    if(!navigationController || !viewController){
        return;
    }
    
    [navigationController pushViewController:viewController animated:YES];
}


#pragma mark - present
+ (void)presentUrl:(NSString *)url animated:(BOOL)animated completion:(void (^)())completion
{
    [self presentUrl:url animated:animated param:nil completion:completion];
}
+ (void)presentUrl:(NSString *)url animated:(BOOL)animated param:(NSDictionary *)param completion:(void (^)())completion
{
    UIViewController *viewController = [self viewControllerForUrl:url param:param];
    [self presentViewController:viewController animated:animated completion:completion];
}
+ (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())completion
{
    UINavigationController *navigationController = [self topNavigationController];
    UIViewController *topViewController = navigationController.topViewController;
    if(!topViewController || !viewController){
        return;
    }
    
    while(topViewController.presentedViewController){
        //假如topViewController已经present过viewController
        topViewController = topViewController.presentedViewController;
    }
    
    if (viewController.navigationController == nil){
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        nav.navigationBar.barTintColor = APP_THEME_COLOR;
        dispatch_async(dispatch_get_main_queue(), ^{
            [topViewController presentViewController:nav animated:animated completion:completion];
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [topViewController presentViewController:viewController animated:animated completion:completion];
        });
    }
}

+ (void)dismissViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())completion
{
    UINavigationController *navigationController = [self topNavigationController];
    if(viewController.navigationController == navigationController){
        //防止viewController就在当前导航控制器的队列中
        NSInteger index = [navigationController.viewControllers indexOfObject:viewController];
        //回退到viewController的上一页面
        index = MIN(MAX(0, index-1), navigationController.viewControllers.count-1);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [navigationController popToViewController:navigationController.viewControllers[index] animated:animated];
        });
        
        if(completion){
            completion();
        }
    }else{
        //正常dismiss
        dispatch_async(dispatch_get_main_queue(), ^{
            [viewController dismissViewControllerAnimated:animated completion:completion];
        });
    }
    
    
}


#pragma mark - safari
+ (BOOL)openUrlInSafari:(NSString *)openUrl
{
    NSString *urlString = openUrl;
//    urlString = [urlString trim];
    
    NSURL *url=  [NSURL URLWithString:urlString];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    return NO;
}

@end
