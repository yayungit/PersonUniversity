//
//  Http.m
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/10.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "Http.h"

@implementation Http
+(void)sharedInstance {
    static Http *http = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        http = [[Http alloc] init];
    });
}


// 1.调用resolveInstanceMethod给个机会让类添加这个实现这个函数
// 2.调用forwardingTargetForSelector让别的对象去执行这个函数
// 3.调用forwardInvocation（函数执行器）灵活的将目标函数以其他形式执行。
// 如果都不中，调用doesNotRecognizeSelector抛出异常。
//+(BOOL)resolveClassMethod:(SEL)sel {
//
//}
//+(BOOL)resolveInstanceMethod:(SEL)sel {
//    
//}
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//
//}
//-(void)forwardInvocation:(NSInvocation *)anInvocation {
//
//}
//-(void)doesNotRecognizeSelector:(SEL)aSelector {
//
//}

@end
