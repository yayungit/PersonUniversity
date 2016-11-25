//
//  TabbarViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 16/11/24.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import "TabbarViewController.h"
#import "NavigationViewController.h"
#import "LockerViewController.h"
#import "MainViewController.h"
@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MainViewController *mainVC = [[MainViewController alloc] init];
    NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:mainVC];
    [self addChildViewController:naVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
