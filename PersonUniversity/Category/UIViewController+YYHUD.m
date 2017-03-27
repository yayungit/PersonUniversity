//
//  UIViewController+YYHUD.m
//  PersonUniversity
//
//  Created by YYSky--Star✨--🦂️ on 2017/3/24.
//  Copyright © 2017年 YYStar. All rights reserved.
//
#import <objc/runtime.h>
#import "UIViewController+YYHUD.h"
static void *yyhud = (void *) "yyhud";
@implementation UIViewController (YYHUD)


-(YYHUD *)YYHUD {
    return objc_getAssociatedObject(self, yyhud);
}
-(void)setYYHUD:(YYHUD *)YYHUD {
    objc_setAssociatedObject(self, yyhud, YYHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (YYHUD *)HUD {
    if (!self.YYHUD) {
        self.YYHUD = [[YYHUD alloc] initWithView:self.view];
    }
    return self.YYHUD;
}
@end
