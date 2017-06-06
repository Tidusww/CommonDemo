//
//  WWRouter.h
//  TidusWWDemo
//
//  Created by Tidus on 17/2/23.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol WWRouterProtocol;
/**
 *  路由
 */
@interface WWRouter : NSObject


+ (instancetype)sharedInstance;

/**
 *  通过url进行路由
 */
+ (void)routeToUrl:(NSString *)url;
+ (void)routeToUrl:(NSString *)url param:(NSDictionary *)param;

@end


/**
 *  需要路由的ViewController需要实现此协议
 */
@protocol WWRouterProtocol <NSObject>

@required
/**
 *  创建需要路由的ViewController
 */
- (UIViewController *)initForRouteWithUrl:(NSString *)url withParam:(NSDictionary *)param;

@end



