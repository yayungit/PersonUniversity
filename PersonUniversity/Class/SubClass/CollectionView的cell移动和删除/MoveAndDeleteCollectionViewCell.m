//
//  MoveAndDeleteCollectionViewCell.m
//  PersonUniversity
//
//  Created by YYSky--Star✨--🦂️ on 2017/3/29.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "MoveAndDeleteCollectionViewCell.h"

@implementation MoveAndDeleteCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setTitle:@"delete" forState:UIControlStateNormal];
        deleteButton.frame = CGRectMake(0, 0, 100, 40);
        deleteButton.titleLabel.textColor = [UIColor redColor];
        deleteButton.hidden = YES;
        [self.contentView addSubview:deleteButton];
        [deleteButton addTarget:self action:@selector(deleteItem:) forControlEvents:UIControlEventTouchUpInside];
        self.deleteButton = deleteButton;
    }
    return self;
}

- (void)deleteItem:(UIButton *)btn {
    if (_deleteBlock) {
        _deleteBlock(self.center);
    }
}

@end
