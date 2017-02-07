//
//  AutoTestTableViewCell.m
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/7.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "AutoTestTableViewCell.h"
#import <PureLayout/PureLayout.h>
#import <Masonry.h>
@implementation AutoTestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UILabel *aLabel = [[UILabel alloc] init];
    aLabel.backgroundColor = [UIColor redColor];
     [self.contentView addSubview:aLabel];
    [aLabel autoConstrainAttribute:ALAttributeLeft toAttribute:ALAttributeLeft ofView:self.contentView];
    [aLabel autoConstrainAttribute:ALAttributeTop toAttribute:ALAttributeTop ofView:self.contentView withOffset:10];
    [aLabel autoSetDimension:ALDimensionWidth toSize:kSCREENWIDTH];
    [aLabel autoSetDimension:ALDimensionHeight toSize:40];
    
    
    UILabel *bLabel = [[UILabel alloc] init];
    bLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:bLabel];
    [bLabel autoConstrainAttribute:ALAttributeLeft toAttribute:ALAttributeLeft ofView:aLabel];
    [bLabel autoConstrainAttribute:ALAttributeTop toAttribute:ALAttributeBottom ofView:aLabel withOffset:10];
    [bLabel autoSetDimension:ALDimensionWidth toSize:kSCREENWIDTH];
    NSLayoutConstraint *heighrLayout = [bLabel autoSetDimension:ALDimensionHeight toSize:40];
   
    
    
    aLabel.text = @"我是30号字体";
    bLabel.text = @"我是30号字体的衍生版";
    // 测试
    // 真时字体大小
    aLabel.font = [UIFont systemFontOfSize:30];
    // 比例缩放后的字体大小
    bLabel.font = [UIFont cwFontWithSize:30];
    
//    // 获取blabel的y值
//    CGFloat y = yLayout.constant;
    CGFloat bLabelHeight = heighrLayout.constant;
    // 比例缩放后的间隔的高度
    CGFloat lineSpecing = [UIView sizeFromIphone6:10];
    self.rowHeight = bLabelHeight*2 + lineSpecing*3;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
