//
//  MainViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 16/11/8.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import "MainViewController.h"
#import <MJRefresh.h>



#import "LockerViewController.h"
#import "SegmentViewController.h"
#import "TimerViewController.h"
#import "GCDTestViewController.h"
#import "MRCTestViewController.h"
#import "AnmationTestViewController.h"
#import "IMTestViewController.h"
#import "CustomFlowLayoutViewController.h"
#import "WKWebViewController.h"
#import "CollectionViewItemCanMoveAndDeleteViewController.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *classArray;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Home";
    classArray = @[@"多线程测试",@"顶部分类类别",@"多个cell添加定时器,自适应布局",@"MRCTest",@"动画和iOS10原生语音识别",@"融云IM",@"重写flowlayout实现横向滚动翻页",@"WKWbView",@"UICollectionView的item移动和删除"];
    [self configUI];
}
// MARK: CONFIG-UI
- (void)configUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH,kSCREENHEIGHT ) style:(UITableViewStylePlain)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    
    __block MJRefreshNormalHeader *herder = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //[herder endRefreshing];
            herder.stateLabel.text = @"~~~~~";
        });
    }];
    //tableView.mj_header = herder;
    
    
    __block MJRefreshGifHeader *giheader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           // giheader.stateLabel.text = @"小飞侠";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [giheader endRefreshing];
            });
        });
    }];
    NSMutableArray *headerImages = [NSMutableArray array];
    for (int i = 1; i <= 12; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"load%d",i]];
        [headerImages addObject:image];
    }
    giheader.stateLabel.hidden = YES;
    giheader.lastUpdatedTimeLabel.hidden = YES;
    [giheader setImages:headerImages forState:MJRefreshStatePulling];
    [giheader setImages:headerImages forState:MJRefreshStateRefreshing];
    [giheader setImages:headerImages forState:MJRefreshStateWillRefresh];
    tableView.mj_header = giheader;
    
    
    __block MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [footer endRefreshingWithNoMoreData];
            // 两者不一样
            //[footer endRefreshing];
            //footer.stateLabel.text = @"------";
            [footer setTitle:@"--0--" forState:MJRefreshStateNoMoreData];

        });
        
    }];
    tableView.mj_footer = footer;
    
    
    
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
            GCDTestViewController *GCDTest = [[GCDTestViewController alloc] init];
            [self.navigationController pushViewController:GCDTest animated:YES];
        }
            break;
        case 1: {
            SegmentViewController *segmentController = [[SegmentViewController alloc] init];
            [self.navigationController pushViewController:segmentController animated:YES];
        }
            break;
        case 2: {
            TimerViewController *timerViewController = [[TimerViewController alloc] init];
            [self.navigationController pushViewController:timerViewController animated:YES];
        }
            break;
        case 3: {
            MRCTestViewController *mrcTestVC = [[MRCTestViewController alloc] init];
            [self.navigationController pushViewController:mrcTestVC animated:YES];
        }
            break;
        case 4: {
            AnmationTestViewController *anmationVC = [[AnmationTestViewController alloc] init];
            [self.navigationController pushViewController:anmationVC animated:YES];
        }
            break;
        case 5: {
            IMTestViewController *IMVC = [IMTestViewController new];
            [self.navigationController pushViewController:IMVC animated:YES];
        }
            break;
        case 6: {
            CustomFlowLayoutViewController *customFLowVC = [CustomFlowLayoutViewController new];
            [self.navigationController pushViewController:customFLowVC animated:YES];
        }
            break;
        case 7: {
            WKWebViewController *webView = [WKWebViewController new];
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
        case 8: {
            CollectionViewItemCanMoveAndDeleteViewController *VC = [CollectionViewItemCanMoveAndDeleteViewController new];
            [self.navigationController pushViewController:VC animated:YES];
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
