//
//  TimerCountDownCell.h
//  PersonUniversity
//
//  Created by 何亚运 on 2017/1/4.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerCountDownCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (nonatomic, assign) NSInteger time;
@end
