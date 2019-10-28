//
//  ReactNativeViewController.m
//  CommonDemo
//
//  Created by Tidus on 2018/1/7.
//  Copyright © 2018年 tidus. All rights reserved.
//

#import "ReactNativeViewController.h"
#import <React/RCTRootView.h>

@interface ReactNativeViewController ()

@property (nonatomic, strong) RCTRootView *reactRootView;

@end

@implementation ReactNativeViewController

- (void)loadView
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (RCTRootView)reactRootView
{
    if(!_reactRootView){
        
        NSURL *jsCodeLocation = [NSURL
                                 URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
        RCTRootView *rootView =
        [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                             moduleName        : @"MyReactNativeApp"
                             initialProperties :
         @{
           @"scores" : @[
                   @{
                       @"name" : @"Alex",
                       @"value": @"42"
                       },
                   @{
                       @"name" : @"Joel",
                       @"value": @"10"
                       }
                   ]
           }
                              launchOptions    : nil];
        
    }
    return _reactRootView;
}



@end
