//
//  CustomFlowLayoutViewController.m
//  PersonUniversity
//
//  Created by YYSky--Star✨--🦂️ on 2017/3/22.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "CustomFlowLayoutViewController.h"
#import "CustomCollectionViewCell.h"
#import "ScrollScale.h" // 滚动中间放大
#import "FlowCover.h"
@interface CustomFlowLayoutViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, assign) NSInteger itemInSection;
@property (nonatomic, strong) NSArray *cellarr;
@end
static NSString *const kCustomCollectionViewCell = @"CustomCollectionViewCell";

@implementation CustomFlowLayoutViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   // self.layout.itemSize = self.myCollectionView.bounds.size;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
   // _arr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29"];
    _arr = @[@"0",@"1",@"2",@"3"];
    
    UICollectionViewFlowLayout *layout = [[FlowCover alloc] init];
    _layout = layout;
    layout.itemSize = CGSizeMake(_myCollectionView.width, _myCollectionView.height);
//    layout.headerReferenceSize = CGSizeZero;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _myCollectionView.collectionViewLayout = layout;
    _myCollectionView.showsVerticalScrollIndicator = NO;
    _myCollectionView.showsHorizontalScrollIndicator = NO;
    _myCollectionView.pagingEnabled = YES;
    [_myCollectionView registerNib:[UINib nibWithNibName:kCustomCollectionViewCell bundle:nil] forCellWithReuseIdentifier:kCustomCollectionViewCell];
   
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arr.count * 2;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell=nil;
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCustomCollectionViewCell forIndexPath:indexPath];
    cell.label.text = _arr[indexPath.item % self.arr.count];

    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
   
   
    //获取当前CollectionView的偏移量
    CGFloat offSetX = scrollView.contentOffset.x;
    /*
     拿总长度为4 举例:
     初始时,让索引为4的Item为默认显示的Item(第2组第1张)
     当偏移量等于0时(第1组第1张,也就是第一张图片),以无动画的方式悄悄的跳转回索引为4的Item(第2组第1张)
     当偏移量等于7倍CollectionView的宽度时(第2组第4张,也就是最后一张图片),同样以无动画的方式跳转回索引为3的Item(第1组第4张)
     因为两组图片是一致的,又是以无动画无察觉的方式跳转的,所以就可以实现无限轮播的效果了
     */
    YYLog(@"%f",scrollView.contentOffset.x);
    if (offSetX == 0) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.arr.count inSection:0];
        
        [self.myCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
    }else if (offSetX == scrollView.bounds.size.width * ( self.arr.count * 2 - 1 )){
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.arr.count - 1 inSection:0];
        
        [self.myCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    // 坐标系转换获得collectionView上面的位于中心的cell
    CGPoint pointInView = [self.view convertPoint:self.myCollectionView.center toView:self.myCollectionView];
    // 获取这一点的indexPath
    NSIndexPath *indexPathNow = [self.myCollectionView indexPathForItemAtPoint:pointInView];
    
    CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[self.myCollectionView cellForItemAtIndexPath:indexPathNow];
    
    [self.myCollectionView bringSubviewToFront:cell];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
