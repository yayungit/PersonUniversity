//
//  AppDelegate.h
//  PersonUniversity
//
//  Created by 何亚运 on 16/11/8.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<BaiduMapAPI_Base/BMKBaseComponent.h>
#import<BaiduMapAPI_Base/BMKMapManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) BMKMapManager *mapManger;


@end

