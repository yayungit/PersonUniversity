//
//  UIFont+XM.m
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/7.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "UIFont+XM.h"
#import "UIView+auto.h"
@implementation UIFont (XM)
+(UIFont *)cwFontWithSize:(CGFloat)fontSize{
    return [UIFont systemFontOfSize:[UIView sizeFromIphone6:fontSize]];
}

+(UIFont *)cwBoldFontWithSize:(CGFloat)fontSize{
    return [UIFont boldSystemFontOfSize:[UIView sizeFromIphone6:fontSize]];
}
@end
