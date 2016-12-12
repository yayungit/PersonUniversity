//
//  SegmentViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 2016/12/9.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import "SegmentViewController.h"
#import "SegmentCustonView.h"
@interface SegmentViewController ()

@end

@implementation SegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    SegmentCustonView *segmentCustonView = [[SegmentCustonView alloc]initWithFrame:CGRectMake(0, 64, kSCREENWIDTH, 40) andClassArray:@[@"游泳",@"旅游",@"爬山",@"游乐场",@"撒哈拉沙漠",@"内蒙古大草原",@"雪山之巅",@"吃",@"喝",@"玩",@"乐"]];
    [self.view addSubview:segmentCustonView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
