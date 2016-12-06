//
//  MainViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 16/11/8.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import "MainViewController.h"
#import "LockerViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Home";
    self.tabBarItem.title = @"Home";
}
- (void)person:(UIBarButtonItem *)bar {
    LockerViewController *lo = [[LockerViewController alloc] init];
    [lo showLeftV];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 375, 200)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
        view.frame = CGRectOffset(view.frame,0 , 300);
        float height = 200;
        [UIView animateWithDuration:.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             
                             view.center = CGPointMake(view.center.x, self.view.frame.size.height - height/2);
                         }
                         completion:^(BOOL finished) {
                             
                             
                         }];
    
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
