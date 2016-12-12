//
//  FillLabelView.h
//  Sample
//
//  Created by sunleepy on 12-10-19.
//  Copyright (c) 2012年 sunleepy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  FillLabelView;
@protocol FillLabelClickDelegate <NSObject>

-(void)ClickLabel:(UILabel *)label;

@end

@interface FillLabelView : UIView

- (void)bindTags:(NSMutableArray*)tags;
@property (nonatomic, weak) id<FillLabelClickDelegate> delegate;
@end
