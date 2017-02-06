//
//  TimerViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 2016/12/30.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import "TimerViewController.h"
#import "TimerCountDownCell.h"
#import "TimerManger.h"
#import "PersonUniversity-Swift.h"
@interface TimerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *timeArray;

@end
static NSString *const kTimerCountDownCell = @"TimerCountDownCell";
@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [tableView registerNib:[UINib nibWithNibName:kTimerCountDownCell bundle:nil] forCellReuseIdentifier:kTimerCountDownCell];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
    [[TimerManger shareInstand] start];
    // 随便设置了一些时间
    self.timeArray = @[@(332737),@(453534),@(4354),@(6000),@(3434),@(10),@(3000),@(40000),@(34534636)];
    
    
}
/** 如果当我们需要网络请求刷新数据的时候*/
- (void)reloadData {
    //    [self.tableView reloadData];
    //    [[TimerManger shareInstand] reload];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimerCountDownCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimerCountDownCell forIndexPath:indexPath];
    cell.time = [self.timeArray[indexPath.row] integerValue];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TestSwift *testSwift  =[[TestSwift alloc] init];
    [testSwift log];
    ViewController *view = [[ViewController alloc] init];
    [self presentViewController:view animated:YES completion:nil];
}



@end
