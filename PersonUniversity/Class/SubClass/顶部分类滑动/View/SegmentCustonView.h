//
//  SegmentCustonView.h
//  PersonUniversity
//
//  Created by 何亚运 on 2016/12/9.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ClassButtonClickProtocol <NSObject>
@optional
- (void)didClassButtonClick:(UIButton *)button andButtonIndex:(NSInteger)index;
@end

@interface SegmentCustonView : UIView
@property (nonatomic, weak) id<ClassButtonClickProtocol> classButtonDelegate;
- (SegmentCustonView *)initWithFrame:(CGRect)frame andClassArray:(NSArray *)classArray;

@end
