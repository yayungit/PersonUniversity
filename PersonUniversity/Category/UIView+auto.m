//
//  UIView+auto.m
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/7.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "UIView+auto.h"

@implementation UIView (autoSize)
//依据iPhone6的尺寸得到当前屏幕相对于iPhone6屏幕尺寸的大小
+(CGFloat)sizeFromIphone6:(CGFloat)size{
#if TARGET_OS_IPHONE
    static float width = 0;
    if (width == 0) {
        width = [UIScreen mainScreen].bounds.size.width;
    }
    return width/375.0*size;
#endif
    return size;
}

//依据真实的尺寸得到iPhone6屏幕尺寸的大小
+(CGFloat)sizeFromRealSize:(CGFloat)size{
#if TARGET_OS_IPHONE
    static float width = 0;
    if (width == 0) {
        width = [UIScreen mainScreen].bounds.size.width;
    }
    return 375.0/width*size;
#endif
    return size;
}

+(CGFloat)scaleFromeIphone6 {
#if TARGET_OS_IPHONE
    static float lineSpecing = 0;
    if (lineSpecing == 0) {
        lineSpecing = [UIScreen mainScreen].bounds.size.width;
    }
    return lineSpecing/375.0;
#endif
    return 1;
}

@end
