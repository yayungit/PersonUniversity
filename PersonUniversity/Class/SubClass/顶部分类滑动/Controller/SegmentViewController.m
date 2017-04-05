//
//  SegmentViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 2016/12/9.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import "SegmentViewController.h"
#import "SegmentCustonView.h"
#import "UIViewController+YYHUD.h"
@interface SegmentViewController ()<ClassButtonClickProtocol>

@end

@implementation SegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    SegmentCustonView *segmentCustonView = [[SegmentCustonView alloc]initWithFrame:CGRectMake(0, 64, kSCREENWIDTH, 40) andClassArray:@[@"游泳",@"旅游",@"爬山",@"游乐场",@"撒哈拉沙漠",@"内蒙古大草原",@"雪山之巅",@"吃",@"喝",@"玩",@"乐"]];
    [self.view addSubview:segmentCustonView];
    
    segmentCustonView.classButtonDelegate = self;
}
- (void)didClassButtonClick:(UIButton *)button andButtonIndex:(NSInteger)index {
//    [self.HUD showMessage:@"ok?"];
    [self.HUD showLoadingRequest:@"网络请求加载数据"];
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.HUD hide];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
