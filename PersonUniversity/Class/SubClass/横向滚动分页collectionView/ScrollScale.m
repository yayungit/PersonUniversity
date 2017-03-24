//
//  ScrollScale.m
//  PersonUniversity
//
//  Created by YYSky--Star✨--🦂️ on 2017/3/23.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "ScrollScale.h"

@implementation ScrollScale
// 这个方法返回所有的布局所需对象,瀑布流也可以重写这个方法实现.
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 1.获取cell对应的attributes对象
    NSArray *arrayAttrs = [super layoutAttributesForElementsInRect:rect];
    
    // 2.计算整体的中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    // 3.修改一下attributes对象
    for (UICollectionViewLayoutAttributes *attr in arrayAttrs) {
        // 3.1 计算每个cell的中心点距离
        CGFloat distance = ABS(attr.center.x - centerX);
        
        // 3.2 距离越大，缩放比越小，距离越小，缩放比越大
        CGFloat factor = 0.003;
        CGFloat scale = 1 / (1 + distance * factor);
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arrayAttrs;
}

// 当bounds发生改变的时候需要重新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

/// 滑动停止
///
/// @param proposedContentOffset 当手指滚动完毕后，自然情况下根据“惯性”，会停留的位置
/// @param velocity              速率,周率
///
/// @return 人为要让它停留的位置
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    // 1.计算中心点位置
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    // 2.计算可视化区域
    CGFloat visibleX = proposedContentOffset.x;
    CGFloat visibleY = proposedContentOffset.y;
    CGFloat visibleW = kSCREENWIDTH;
    CGFloat visibleH = self.collectionView.bounds.size.height;
    CGRect visibleRect = CGRectMake(visibleX, visibleY, visibleW, visibleH);
    
    // 3.获取可视区域的cell的attribute对象
    NSArray *attrs = [self layoutAttributesForElementsInRect:visibleRect];
    
    // 4.比较出最小的偏移
    int min_idx = 0;
    UICollectionViewLayoutAttributes *min_attr = attrs[min_idx];
    
    // 5.循环比较出最小的
    for (int i = 1; i< attrs.count; i++){
        // 5.1min_attr和中心点的距离
        CGFloat distance1 = ABS(min_attr.center.x - centerX);
        
        // 5.2当前循环的attr和中心点的距离
        UICollectionViewLayoutAttributes *currentAttr = attrs[i];
        CGFloat distance2 = ABS(currentAttr.center.x - centerX);
        
        if (distance2 < distance1) {
            min_idx = i;
            min_attr = currentAttr;
        }
    }
    // 6.计算出最小的偏移值
    CGFloat offsetX = min_attr.center.x - centerX;
    
    return CGPointMake(proposedContentOffset.x + offsetX, proposedContentOffset.y);
}
@end
