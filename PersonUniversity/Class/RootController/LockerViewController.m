//
//  LockerViewController.m
//  CT
//
//  Created by 何亚运 on 16/3/9.
//  Copyright © 2016年 YaYunHe. All rights reserved.
//

#import "LockerViewController.h"
@interface LockerViewController ()
{
    UIView *alphaView;
}
@property (nonatomic, assign) CGFloat scalef; // 设置一个滑动的偏移
@property (nonatomic, assign) CGFloat speedF; // 设置一个滑动速度
@end

@implementation LockerViewController
- (instancetype)initWithMainVC:(UIViewController *)mainVC leftVC:(UIViewController *)leftVC backGroundImage:(UIImage *)image{
    self = [super init];
    if (self) {
        self.speedF = 0.5;
        self.mainVC = mainVC;
        self.leftVC = leftVC;
        leftVC.view.frame = self.view.bounds;
        mainVC.view.frame = self.view.bounds;
        [self addChildViewController:mainVC];
        [self addChildViewController:leftVC];
        [self.view addSubview:_leftVC.view];
        [self.view addSubview:_mainVC.view];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *alphView = [[UIView alloc] initWithFrame:self.view.frame];
    alphView.backgroundColor = [UIColor blackColor];
    alphView.alpha = 0.3;
    [alphView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenLeft)]];
    alphaView = alphView;
    alphaView.hidden = YES;
    [_mainVC.view addSubview:alphView];
//            UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.frame];
//            imageV.image = image;
//            [self.view addSubview:imageV];
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//    [self.mainVC.view addGestureRecognizer:pan];

//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    [tap setNumberOfTapsRequired:1];
//    [_mainVC.view addGestureRecognizer:tap];
    _leftVC.view.hidden = YES;
}


// 滑动手势

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.view];
    self.scalef += point.x*_speedF;
    if (pan.view.frame.origin.x>=0) { // 右滑
        pan.view.center = CGPointMake(pan.view.center.x+point.x*_speedF, pan.view.center.y);
        // 根据速度缩放主视图
//        pan.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1-_scalef/1000, 1-_scalef/1000);
        pan.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        [pan setTranslation:CGPointMake(0, 0) inView:self.view];
        _leftVC.view.hidden = NO;
        /**
         * 左滑没有设置
         */
    } else if (pan.view.frame.origin.x < 0){
       // 可以添加右侧抽屉
    } else { // 否则显示主视图
        pan.view.center    = CGPointMake(pan.view.center.x+point.x*_speedF, pan.view.center.y);
        pan.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0+_scalef/1000, 1.0+_scalef/1000);
        
        [pan setTranslation:CGPointMake(0, 0) inView:self.view];
        _leftVC.view.hidden = YES;
    }

    
    // 滑动结束时
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (_scalef>50*_speedF) {
            [self showLeftV];
        }else {
            [self showMainV];
        }
    }
}

// 轻拍手势
- (void)handleTap:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateEnded) {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        [UIView commitAnimations];
        _scalef = 0;
    }
}
//  展示主视图
- (void)showMainV {
    
    [UIView beginAnimations:nil context:nil];
    _mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    _mainVC.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}
//  展示左视图
- (void)showLeftV {
    alphaView.hidden = NO;
    [_mainVC.view bringSubviewToFront:alphaView];
    [UIView beginAnimations:nil context:nil];
    _mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0); // 缩放系数
    _mainVC.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width*5/4,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}
- (void)hiddenLeft {
    alphaView.hidden = YES;
    [self showMainV];
}

@end
