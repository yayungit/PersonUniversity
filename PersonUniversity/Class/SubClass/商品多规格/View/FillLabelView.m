//
//  FillLabelView.m
//  Sample
//
//  Created by sunleepy on 12-10-19.
//  Copyright (c) 2012年 sunleepy. All rights reserved.
//

#import "FillLabelView.h"
#import "FillLabel.h"

@implementation FillLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}
- (void)bindTags:(NSMutableArray*)tags
{
    CGFloat frameWidth = self.frame.size.width;
    
    CGFloat tagsTotalWidth = 0.0f;
    CGFloat tagsTotalHeight = 0.0f;
    
    CGFloat tagHeight = 0.0f;
    for (NSString *tag in tags)
    {
        FillLabel *fillLabel = [[FillLabel alloc] initWithFrame:CGRectMake(tagsTotalWidth, tagsTotalHeight, 0, 0)];
        fillLabel.text = tag;
        tagsTotalWidth += fillLabel.frame.size.width + 10.0f;
        tagHeight = fillLabel.frame.size.height;
        
        if(tagsTotalWidth > frameWidth)
        {
            tagsTotalHeight += fillLabel.frame.size.height + 17.0f;
            tagsTotalWidth = 0.0f;
            fillLabel.frame = CGRectMake(tagsTotalWidth, tagsTotalHeight, fillLabel.frame.size.width, fillLabel.frame.size.height);
            tagsTotalWidth += fillLabel.frame.size.width + 10.0f;
        }
      
        [self addSubview:fillLabel];
        fillLabel.userInteractionEnabled=YES;
        //添加点击时间
        UITapGestureRecognizer *tapLabel=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick:)];
        [fillLabel addGestureRecognizer:tapLabel];
    }
    tagsTotalHeight += tagHeight;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, tagsTotalHeight);
}
-(void)labelClick:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(ClickLabel:)]) {
        UILabel *label=(UILabel *)tap.view;
        [self.delegate ClickLabel:label];
    }
}

@end
