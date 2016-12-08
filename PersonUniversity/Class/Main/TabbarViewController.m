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
#import "CommunityViewController.h"
@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainVC = [[MainViewController alloc] init];
    NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:_mainVC];
    
    CommunityViewController *communityVC = [[CommunityViewController alloc] init];
    NavigationViewController *communityNaVC = [[NavigationViewController alloc] initWithRootViewController:communityVC];
    
    self.viewControllers = @[naVC,communityNaVC];
    
    NSArray *titles = @[@"Home",@"Community"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.selectedIndex = 0;
        obj.title = titles[idx];
    }];
    [[UITabBar appearance] setTintColor:[UIColor purpleColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    YYLog(@"--------");
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
