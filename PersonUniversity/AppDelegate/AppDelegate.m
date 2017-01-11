//
//  AppDelegate.m
//  PersonUniversity
//
//  Created by 何亚运 on 16/11/8.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "LeftViewController.h"
#import "LockerViewController.h"
#import "MainViewController.h"


@interface AppDelegate ()
@property (nonatomic, strong) LockerViewController *lockerViewController;
@end
static NSString *const BMAK = @"Lv0QmjMHDnQ9iO6sEyBNg01XWnhbExnq";
static NSString *const UMAppKey = @"58733ab375ca35049e000aad";
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _mapManger = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManger start:BMAK generalDelegate:nil];
    if (!ret) {
        YYLog(@"manger start failed!");
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    TabbarViewController *tabbarVC = [[TabbarViewController alloc] init];
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    LockerViewController *lockerViewController = [[LockerViewController alloc] initWithMainVC:tabbarVC leftVC:leftVC backGroundImage:nil];
    _lockerViewController = lockerViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = lockerViewController;
    [self.window makeKeyAndVisible ];
    UIViewController *vc = (MainViewController *)tabbarVC.mainVC;
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(lefClick:)];
    return YES;
}
// 展示左视图
- (void)lefClick:(UIBarButtonItem *)item {
    [_lockerViewController showLeftV];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
