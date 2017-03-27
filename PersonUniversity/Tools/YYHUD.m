//
//  YYHUD.m
//  PersonUniversity
//
//  Created by YYSky--Star✨--🦂️ on 2017/3/24.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "YYHUD.h"
#import <MBProgressHUD.h>
@interface YYHUD ()<MBProgressHUDDelegate>
@property (nonatomic, weak) UIView *tempView;
@property (nonatomic, strong) MBProgressHUD *HUD;
@end

@implementation YYHUD
-(instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.tempView = view;
    }
    return self;
}
- (void)creatHUD {
    _HUD = [[MBProgressHUD alloc] initWithView:self.tempView];
    _HUD.mode = MBProgressHUDModeText;
    _HUD.delegate = self;
    [self.tempView addSubview:_HUD];
}
- (void)showLoadingRequest:(NSString *)message {
    [self showMessage:message duration: -1];
}
- (void)showMessage:(NSString *)message {
    [self showMessage:message duration:1.0];
}
- (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration {
    [self creatHUD];
    _HUD.label.text = nil;
    _HUD.label.text = message;
    [self.HUD showAnimated:YES];
    
    if (duration>0) {
        [self.HUD hideAnimated:YES afterDelay:duration];
    }
    
}


- (void)hide {
    [self hudWasHidden:_HUD];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    if (hud || self.HUD.delegate) {
        [self.HUD removeFromSuperview];
        self.HUD.delegate = nil;
        self.HUD = nil;
    }
    
}
@end
