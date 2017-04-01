//
//  MoveAndDeleteCollectionViewCell.h
//  PersonUniversity
//
//  Created by YYSky--Star✨--🦂️ on 2017/3/29.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteBlock)(CGPoint );

@interface MoveAndDeleteCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, copy) DeleteBlock deleteBlock;
@end
