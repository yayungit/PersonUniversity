//
//  LockerViewController.h
//  CT
//
//  Created by 何亚运 on 16/3/9.
//  Copyright © 2016年 YaYunHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LockerViewController : UIViewController

@property (nonatomic, strong) UIViewController *mainVC;
@property (nonatomic, strong) UIViewController *leftVC;
@property (nonatomic, assign) CGFloat speedF; // 设置一个滑动速度
//  初始化方法
- (instancetype)initWithMainVC:(UIViewController *)mainVC leftVC:(UIViewController *)leftVC backGroundImage:(UIImage *)image;
//  展示主视图
- (void)showMainV;
//  展示左视图，即左抽屉
- (void)showLeftV;

@end
