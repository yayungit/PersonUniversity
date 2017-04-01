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
#import <UMSocialCore/UMSocialCore.h>
#import <WXApi.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <RongIMKit/RongIMKit.h>
#import <JSPatchPlatform/JSPatch.h>
#import <JPEngine.h>

@interface AppDelegate () <RCIMUserInfoDataSource>
@property (nonatomic, strong) LockerViewController *lockerViewController;
@end
static NSString *const BMAK = @"Lv0QmjMHDnQ9iO6sEyBNg01XWnhbExnq";
static NSString *const UMAppKey = @"58733ab375ca35049e000aad";
static NSString *const WX_AppKey = @"wx9ed67d121cd660b1";
static NSString *const WX_AppSecret = @"9b65d6206d8aaf6070f359bce9177cfc";
// 融云
static NSString *const RongYunAppKey = @"uwd1c0sxuhwy1";
static NSString *const RongYunAppSecret = @"X2mGEkqr43h9";
static NSString *const RongYunToken = @"0f52+tFmt3IlHz9uQZuv+V21eZtTq2YMEAQwTuYI+4KSDk6phPfvAhIRYBMew++PEhEBquJkhMu8Yj7eXTgaUg==";

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
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAppKey];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WX_AppKey appSecret:WX_AppSecret redirectURL:nil];
//    [WXApi registerApp:WX_AppKey];
    [Fabric with:@[[Crashlytics class]]];
    
    
    // 注册融云
    [[RCIM sharedRCIM] initWithAppKey:RongYunAppKey];
    
    [[RCIM sharedRCIM] connectWithToken:RongYunToken success:^(NSString *userId) {
        YYLog(@"userId = %@", userId);
        // 设置获取设置用户信息的datasource
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
    } error:^(RCConnectErrorCode status) {
        YYLog(@"错误码 = %ld",(long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        YYLog(@"token错误");
    }];
    YYLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES));
    [JSPatch startWithAppKey:@"f869a8a5aed12b7f"];

    [JSPatch setupRSAPublicKey:@"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDZwhdlImcUKNL+wlvG2vAwrIqr\nvI3Wlf2xlbE38YzFT93v2LufCth9/ujGcgcArjaebP6k5/RzNceO0hEde0TydAcY\n6jUZa9dcGYReMTy0dWv5Rt1ebq7jw4XidUPeCZR31QEvcXAA4znwORbV2RVjwNDX\nbGYeehbWPZhPV8u3AwIDAQAB\n-----END PUBLIC KEY-----"];
    
#ifdef DEBUG
    [JSPatch setupDevelopment];
#endif
      [JSPatch sync];

    [JSPatch setupCallback:^(JPCallbackType type, NSDictionary *data, NSError *error) {
        if (type == JPCallbackTypeJSException) {
            NSAssert(NO, data[@"msg"]);
        }
    }];
//    [JSPatch testScriptInBundle];
   

    return YES;
}
// 展示左视图
- (void)lefClick:(UIBarButtonItem *)item {
    [_lockerViewController showLeftV];
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    BOOL resule = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!resule) {
        
    }
    return resule;
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

#pragma mark - RCIMUserInfoDataSource
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    if ([userId isEqualToString:@"test2"]) {
        RCUserInfo *userinfo = [[RCUserInfo alloc] init];
        userinfo.userId = userId;
        userinfo.name = @"测试名称";
        userinfo.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";
        return completion(userinfo);
    }
    return completion(nil);
}


@end
