//
//  TimerManger.h
//  PersonUniversity
//
//  Created by 何亚运 on 2016/12/30.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerManger : NSObject
@property (nonatomic, assign) NSTimeInterval timeInterval;
+ (instancetype)shareInstand;
- (void)start;
- (void)reload;
- (void)stop;
@end
