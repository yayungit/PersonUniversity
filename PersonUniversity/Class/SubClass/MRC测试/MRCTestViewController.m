//
//  MRCTestViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/9.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "MRCTestViewController.h"

@interface MRCTestViewController ()

@end



@implementation MRCTestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray*ary=[[NSMutableArray array]retain];
    NSString *str = [NSString stringWithFormat:@"test"];
    NSString *string = [NSString stringWithFormat:@"test"];
    
    NSLog(@"%@%ld",str,[string retainCount]);
    [str retain];
    [ary addObject:str];
    NSLog(@"%@%ld",str,[str retainCount]);
    [str retain];
    [str release];
    [str release];
    NSLog(@"%@%ld",str,(unsigned long)[str retainCount]);
    [ary removeAllObjects];
    NSLog(@"%@%ld",str,[str retainCount]);
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
