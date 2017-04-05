//
//  YYHUD.h
//  PersonUniversity
//
//  Created by YYSky--Star✨--🦂️ on 2017/3/24.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>
@interface YYHUD : NSObject
-(instancetype)initWithView:(UIView *)view;

//- (void)showOnWindowMessage:(NSString *)message;
// 网络请求时 不设置延时；
- (void)showLoadingRequest:(NSString *)message;

// 默认展示当前控制器的view,延时默认1.0s
- (void)showMessage:(NSString *)message;
- (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration;
- (void)showMessage:(NSString *)message mode:(MBProgressHUDMode)mode duration:(NSTimeInterval)duration;
- (void)hide;
@end
