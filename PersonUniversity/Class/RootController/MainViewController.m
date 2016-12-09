//
//  MainViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 16/11/8.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import "MainViewController.h"
#import "LockerViewController.h"
#import "SegmentViewController.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *classArray;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Home";
    classArray = @[@"addSubView动画",@"顶部分类类别"];
    [self configUI];
}
// MARK: CONFIG-UI
- (void)configUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH,kSCREENHEIGHT ) style:(UITableViewStylePlain)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}
// MARK: UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return classArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
        cell.textLabel.text = classArray[indexPath.row];
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            
        }
            break;
        case 1: {
            SegmentViewController *segmentController = [[SegmentViewController alloc] init];
            [self.navigationController pushViewController:segmentController animated:YES];
        }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
