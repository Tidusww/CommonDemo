//
//  WWBaseTabBarController.m
//  ExEducation
//
//  Created by Tidus on 17/4/27.
//  Copyright © 2017年 ExEdu. All rights reserved.
//

#import "WWBaseTabBarController.h"

NSString * const kWWBaseTabBarControllerRootKey = @"root-controllers";
NSString * const kWWBaseTabBarControllerConfiguration = @"WWBaseTabBarConfiguration";
NSString * const kWWBaseTabBarControllerConfigurationKeyTitle = @"title";
NSString * const kWWBaseTabBarControllerConfigurationKeyImage = @"image";
NSString * const kWWBaseTabBarControllerConfigurationKeySelectedImage = @"selectedImage";

@interface WWBaseTabBarController () <UITabBarControllerDelegate>

@property (nonatomic, strong) NSArray *rootControllers;

@end

@implementation WWBaseTabBarController

- (instancetype)initWithConfig:(NSDictionary *)config
{
    if(self = [super init]){
        //  初始化controllers
        _rootControllers = [config valueForKey:kWWBaseTabBarControllerRootKey];
        self.viewControllers = [self rootViewControllers:_rootControllers];
        
        self.delegate = self;
        self.selectedIndex = 0;
        
        
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setBarTintColor:TAB_BAR_TINT_COLOR];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (NSArray *)rootViewControllers:(NSArray *)rootControllers {
    NSMutableArray *rootViewControllers = [NSMutableArray array];
    
    //分栏配置信息
    NSString *configPath = [[NSBundle mainBundle] pathForResource:kWWBaseTabBarControllerConfiguration ofType:@".plist"];
    NSArray *tabBarConfigArray = [NSArray array];
    if(configPath.length != 0){
        tabBarConfigArray = [NSArray arrayWithContentsOfFile:configPath];
    }
    
    for (NSInteger i=0; i<rootControllers.count; i++) {
        NSString *clazz = rootControllers[i];
        if (clazz.length != 0) {
            UIViewController *controller = [[NSClassFromString(clazz) alloc] init];
            WWBaseNavigationController *nav = [[WWBaseNavigationController alloc] initWithRootViewController:controller];
            
            NSDictionary *tabBarConfig = nil;
            if(i < tabBarConfigArray.count){
                tabBarConfig = tabBarConfigArray[i];
            }
            
            //分栏信息
            if(tabBarConfig){
                NSString *title = [tabBarConfig ee_stringForKey:kWWBaseTabBarControllerConfigurationKeyTitle];
                NSString *image = [tabBarConfig ee_stringForKey:kWWBaseTabBarControllerConfigurationKeyImage];
                NSString *selectedImage = [tabBarConfig ee_stringForKey:kWWBaseTabBarControllerConfigurationKeySelectedImage];

                //样式
                nav.tabBarItem.title = title;
                nav.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TAB_BAR_UNSELECT_COLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
                [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TAB_BAR_SELECTED_COLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
            }
            
            [rootViewControllers addObject:nav];
        }
    }
    return rootViewControllers;
}

- (void)setTabBarItemBadgeValue:(NSInteger)badgeValue itemIndex:(NSInteger)index
{
    if(index >= self.viewControllers.count){
        return;
    }
    UIViewController *viewController = self.viewControllers[index];
    if(badgeValue == 0){
        viewController.tabBarItem.badgeValue = nil;
        return;
    }
    
    if (badgeValue >0 ) {
        if (badgeValue > 99) {
            viewController.tabBarItem.badgeValue = @"99+";
        }else {
            viewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", (long)badgeValue];
        }
    }
}


#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}



@end
