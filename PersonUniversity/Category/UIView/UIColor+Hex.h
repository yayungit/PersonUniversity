//
//  UIColor+Hex.h
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/6.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

+ (UIColor *)colorWithHex:(NSInteger)hexValue;
@end
