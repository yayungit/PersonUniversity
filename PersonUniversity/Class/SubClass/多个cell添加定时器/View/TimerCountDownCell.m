//
//  TimerCountDownCell.m
//  PersonUniversity
//
//  Created by 何亚运 on 2017/1/4.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "TimerCountDownCell.h"
#import "TimerManger.h"
@implementation TimerCountDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerAction) name:@"timerAction" object:nil];
}
- (void)timerAction {
    NSInteger countDown = self.time - [TimerManger shareInstand].timeInterval;
    if (countDown<0) {
        self.countDownLabel.text = @"00:00:00";
        return;
    }
    self.countDownLabel.text = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", countDown/3600, (countDown/60)%60, countDown%60];
}
- (void)dealloc {
    [[TimerManger shareInstand] stop];
}

@end
