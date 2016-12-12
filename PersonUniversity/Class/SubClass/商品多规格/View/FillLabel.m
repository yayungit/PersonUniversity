//
//  FillLabel.m
//  Sample
//
//  Created by sunleepy on 12-10-19.
//  Copyright (c) 2012年 sunleepy. All rights reserved.
//

#import "FillLabel.h"

#define MAX_SIZE_HEIGHT 10000
#define DEFAULT_BACKGROUDCOLOR  [UIColor whiteColor]
#define DEFAULT_TEXTCOLOR  UIColorFromRGB(COLOR_666666_WORDCOLOR)
#define DEFAULT_FONT [UIFont systemFontOfSize:14]
#define DEFAULT_TEXTALIGNMENT NSTextAlignmentCenter
#define DEFAULT_RADIUS 5.0f

@implementation FillLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = DEFAULT_BACKGROUDCOLOR;
        self.textColor = DEFAULT_TEXTCOLOR;
        self.font =DEFAULT_FONT;
        self.textAlignment = DEFAULT_TEXTALIGNMENT;
       
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = DEFAULT_RADIUS;
        self.layer.borderWidth=2.0f;
        self.layer.borderColor=[UIColor whiteColor].CGColor;

    }
    return self;
}

-(void)setRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
}

-(void)setText:(NSString *)text
{
    super.text = text;
    
    CGSize size=[Tools sizeOfString:text withFont:self.font width:SCREEN_WIDTH];
    
  
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width + 20, 26);
}

@end
