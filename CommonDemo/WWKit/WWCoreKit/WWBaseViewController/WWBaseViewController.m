//
//  WWBaseViewController.m
//  TidusWWDemo
//
//  Created by Tidus on 17/2/23.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import "WWBaseViewController.h"
#import "WWRouter.h"

@interface WWBaseViewController () <WWRouterProtocol>

@end

@implementation WWBaseViewController

#pragma mark - WWRouterProtocol
- (UIViewController *)initForRouteWithUrl:(NSString *)url withParam:(NSDictionary *)param;
{
    //初始化
    self = [super init];
    if(self){
        [param enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            @try {
                [self setValue:obj forKeyPath:key];
            } @catch (NSException *exception) {
                NSLog(@"%@ is not key value coding-compliant for the key %@.", [self class], key);
            } @finally {
                
            }
        }];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
