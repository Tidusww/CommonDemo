//
//  WWRouter.h
//  ExEducation
//
//  Created by Tidus on 17/4/14.
//  Copyright © 2017年 ExEdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WWRouterProtocol;
@interface WWRouter : NSObject

/**
 *  路由
 */
+ (void)routeToUrl:(NSString *)url;
+ (void)routeToUrl:(NSString *)url param:(NSDictionary *)param;

/**
 *  模态显示
 */
+ (void)presentUrl:(NSString *)url animated:(BOOL)animated completion:(void (^)())completion;
+ (void)presentUrl:(NSString *)url animated:(BOOL)animated param:(NSDictionary *)param completion:(void (^)())completion;
+ (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())completion;
+ (void)dismissViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)())completion;

/**
 *  通过safari打开链接
 */
+ (BOOL)openUrlInSafari:(NSString *)openUrl;


+ (UITabBarController *)rootTabBarController;
+ (UINavigationController *)topNavigationController;

@end








/**
 *  需要路由的ViewController需要实现此协议
 */
@protocol WWRouterProtocol <NSObject>

@required
/**
 *  创建需要路由的ViewController
 */
- (UIViewController *)initForRouterWithUrl:(NSString *)url param:(NSDictionary *)param;

@end
