//
//  WWNavigationController.m
//  TidusWWDemo
//
//  Created by Tidus on 16/3/14.
//  Copyright © 2016年 Tidus. All rights reserved.
//

#import "WWBaseNavigationController.h"

@interface WWBaseNavigationController ()

@end

@implementation WWBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - getter

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:YES];
    
    
}

@end
