//
//  TimerManger.m
//  PersonUniversity
//
//  Created by 何亚运 on 2016/12/30.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import "TimerManger.h"

@interface TimerManger ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation TimerManger

+ (instancetype)shareInstand {
    static dispatch_once_t onceToken;
    static TimerManger *manger = nil;
    dispatch_once(&onceToken, ^{
        manger = [[TimerManger alloc] init];
    });
    return manger;
}
- (void)start {
    [self timer];
}
- (void)reload {
    self.timeInterval = 0;
}
- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerWithTime:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
- (void)timerWithTime:(NSTimer *)timer {
    self.timeInterval ++;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"timerAction" object:timer userInfo:nil];
}
- (void)stop {
    [self.timer invalidate];
    self.timer = nil;
}
@end
