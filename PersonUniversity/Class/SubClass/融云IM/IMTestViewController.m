//
//  IMTestViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/21.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "IMTestViewController.h"

@interface IMTestViewController ()

@end

@implementation IMTestViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
-(instancetype)init {
    self = [super init];
    if (self) {
        // 设置需要显示的会话类型
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_CHATROOM),@(ConversationType_GROUP),@(ConversationType_APPSERVICE),@(ConversationType_SYSTEM)]];
        // 设置聚合显示   （聚合显示的类型，哪些类型的会话需要聚合显示）
        [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),@(ConversationType_GROUP)]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置会话cell背景色
    self.cellBackgroundColor = [UIColor cyanColor];
}

// 将要展示cell时进行一些操作
- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    if (model.conversationType == ConversationType_PRIVATE) {
        RCConversationCell *conversationCell = (RCConversationCell *)cell;
        conversationCell.conversationTitle.textColor = [UIColor redColor];
    }
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        // 如果是聚合显示的话
        IMTestViewController *IMVC = [IMTestViewController new];
        [IMVC setDisplayConversationTypes:@[@(model.conversationType)]];
        // 设置下一级不聚合显示了。
        [IMVC setCollectionConversationType:nil];
        IMVC.isEnteredToCollectionViewController = YES;
        [self.navigationController pushViewController:IMVC animated:YES];
    } else if (model.conversationType == ConversationType_PRIVATE) {
        // 单聊的情况下，进入会话聊天界面
        RCConversationViewController *rvVC = [[RCConversationViewController alloc] init];
        rvVC.conversationType = model.conversationType;
        rvVC.targetId = model.targetId;
        rvVC.title = @"会话标题";
        // tabbar会把输入框盖住了
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:rvVC animated:YES];
    }
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
