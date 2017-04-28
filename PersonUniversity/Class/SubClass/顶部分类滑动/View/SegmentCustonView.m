//
//  SegmentCustonView.m
//  PersonUniversity
//
//  Created by 何亚运 on 2016/12/9.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import "SegmentCustonView.h"

#define kSCREENWIDTH   [UIScreen mainScreen].bounds.size.width
#define kSCREENHEIGHT  [UIScreen mainScreen].bounds.size.height

// 暂时没写
typedef NS_ENUM(NSUInteger, ScrollbarType) {
    ScrollbarTypeDefault, // 默认下划线
    ScrollbarTypeRound, // 圆角背景
    ScrollbarTypeEnlarged, // 字体放大
};
@interface SegmentCustonView ()
{
    UIScrollView *scrollView;
    NSMutableArray *buttonArray;
    NSMutableArray *lineLabelArray;
    ScrollbarType scrollBarType;
    float lastContentSizeWidth;
}
// 用来接受外界传来的数组，及分类的组合
@property (nonatomic, strong) NSArray *classTemArray;
@property (nonatomic, strong) UILabel *lineLabel;
@end

static NSInteger const kTag = 10000;
// 默认字体大小
static NSInteger const titleFont = 14;
// 按钮之间的间隔
static NSInteger const lineSpace = 10;
// 默认下划线的颜色
#define color  [UIColor redColor]

@implementation SegmentCustonView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI:frame];
    }
    return self;
}

- (SegmentCustonView *)initWithFrame:(CGRect)frame andClassArray:(NSArray *)classArray {
    self.classTemArray = classArray;
    SegmentCustonView *view = [self initWithFrame:frame];
    return view;
}

- (void)configUI:(CGRect)frame {
    CGFloat contentSizeWidth = 0;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    buttonArray = [NSMutableArray array];
    lineLabelArray = [NSMutableArray array];
    for (int i = 0; i < _classTemArray.count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [titleButton setTitle:_classTemArray[i] forState:UIControlStateNormal];
        [titleButton setTintColor:[UIColor blackColor]];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:titleFont];
       
        
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat width = [_classTemArray[i] boundingRectWithSize:CGSizeMake(0, frame.size.height-2) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:titleFont]} context:nil].size.width;
        titleButton.tag = i+kTag;
        // 找到上一个button的位置
        if (i == 0) {
            titleButton.frame = CGRectMake(lineSpace, 0, width, frame.size.height);
        } else {
            UIButton *temButton = buttonArray[i-1];
            titleButton.frame = CGRectMake(lineSpace+temButton.frame.origin.x+temButton.frame.size.width, 0, width, frame.size.height);
        }
        
        [buttonArray addObject:titleButton];
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleButton.frame.origin.x, titleButton.frame.size.height -2, titleButton.frame.size.width, 2)];
        lineLabel.hidden = YES;
        [scrollView addSubview:lineLabel];
        [scrollView addSubview:titleButton];
        [lineLabelArray addObject:lineLabel];
        contentSizeWidth += titleButton.frame.size.width + lineSpace;
        if (i == 0) {
            [titleButton setTitleColor:color forState:UIControlStateNormal];
            lineLabel.backgroundColor = color;
        }
    }
    _lineLabel = [[UILabel alloc] init];
    UILabel *label = lineLabelArray[0];
    _lineLabel.frame = label.frame;
    _lineLabel.backgroundColor = color;
    [scrollView addSubview:_lineLabel];
    
    scrollView.contentSize = CGSizeMake(contentSizeWidth+lineSpace, frame.size.height);
    UIView *viewsss = [UIView new];
    [self addSubview:viewsss];
    [self addSubview:scrollView];
    lastContentSizeWidth = contentSizeWidth;
}


// button Click
- (void)titleButtonClick:(UIButton *)button {
    [buttonArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *temLineLabel = lineLabelArray[idx];
        if (btn == button) {
            [btn setTitleColor:color forState:UIControlStateNormal];
            temLineLabel.backgroundColor = color;
            if (lastContentSizeWidth>kSCREENWIDTH) {
//                YYLog(@"---%f,====%f-----%f",scrollView.contentOffset.x,btn.frame.origin.x,scrollView.contentSize.width-kSCREENWIDTH/2);
                
                if (btn.frame.origin.x >= kSCREENWIDTH/2 && btn.frame.origin.x<=scrollView.contentSize.width-kSCREENWIDTH/2) {
                    // 中间部分
                    [UIView animateWithDuration:.3 animations:^{
                        scrollView.contentOffset = CGPointMake(btn.frame.origin.x-kSCREENWIDTH/2+btn.frame.size.width/2, 0);
                    }];
                } else if (btn.frame.origin.x<kSCREENWIDTH/2) {
                    // 前半部分
                    [UIView animateWithDuration:.3 animations:^{
                        scrollView.contentOffset = CGPointMake(0, 0);
                    }];
                } else {
                    // 后半部分
                    [UIView animateWithDuration:.3 animations:^{
                        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width-kSCREENWIDTH, 0);
                    }];
                }
                [UIView animateWithDuration:.3 animations:^{
                    _lineLabel.frame = temLineLabel.frame;
                }];
            } else {
                [UIView animateWithDuration:.3 animations:^{
                    _lineLabel.frame = temLineLabel.frame;
                }];
            }
            
        } else {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
        }
    }];
    
    if (_classButtonDelegate && [_classButtonDelegate respondsToSelector:@selector(didClassButtonClick:andButtonIndex:)]) {
        [_classButtonDelegate didClassButtonClick:button andButtonIndex:button.tag-kTag];
    }
}




@end
