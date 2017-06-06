//
//  WWRouter.m
//  TidusWWDemo
//
//  Created by Tidus on 17/2/23.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import "WWRouter.h"

#define kUrlPList @"WWRouter"

static NSDictionary *urlMap = nil;

@implementation WWRouter

#pragma mark - 单例
+ (instancetype)sharedInstance
{
    static WWRouter *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[WWRouter alloc] init];
        NSString *urlPath = [[NSBundle mainBundle] pathForResource:kUrlPList ofType:@".plist"];
        if(urlPath.length != 0){
            urlMap = [NSDictionary dictionaryWithContentsOfFile:urlPath];
        }
    });
    
    return sharedManager;
}
//WWOnceToken(WWRouter);

#pragma mark - route
+ (void)routeToUrl:(NSString *)url
{
    [[self sharedInstance] routeToUrl:url param:nil];
}

+ (void)routeToUrl:(NSString *)url param:(NSDictionary *)param
{
    [[self sharedInstance] routeToUrl:url param:param];
}

- (void)routeToUrl:(NSString *)url
{
    [self routeToUrl:url param:nil];
}

- (void)routeToUrl:(NSString *)url param:(NSDictionary *)param
{
    if(url.length == 0){
        NSLog(@"%s : %@", __func__, @"url is nil");
        return;
    }
    
    NSString *className = [urlMap objectForKey:url];
    if(className.length == 0){
        NSLog(@"%s : %@", __func__, @"className is nil");
        return;
    }
    
    Class aClass = NSClassFromString(className);
    if(aClass && [aClass conformsToProtocol:@protocol(WWRouterProtocol)]){
        UIViewController *viewController = [[aClass alloc] initForRouteWithUrl:url withParam:param];
        if(viewController){
            UINavigationController *navigationController = [self topNavigationController];
            [navigationController pushViewController:viewController animated:YES];
        }
    }else{
        NSAssert(NO, @"类必须实现 @WWRouterProtocol 协议。");
    }
}


- (UINavigationController *)topNavigationController
{
    WWBaseAppDelegate *delegate = (WWBaseAppDelegate *)[UIApplication sharedApplication].delegate;
    UINavigationController *navigationController = [delegate navigationControllerForRoute];
    
    return navigationController;
}


@end
