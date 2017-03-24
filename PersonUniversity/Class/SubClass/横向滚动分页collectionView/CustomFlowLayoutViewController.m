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
@interface CustomFlowLayoutViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger _currentIndex;
    
    CGFloat _dragStartX;
    
    CGFloat _dragEndX;
}
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, assign) NSInteger itemInSection;
@property (nonatomic, strong) NSArray *cellarr;
@end
//居中卡片宽度与据屏幕宽度比例
static float CardWidthScale = 0.7f;
static float CardHeightScale = 0.8f;
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
    
    UICollectionViewFlowLayout *layout = [[ScrollScale alloc] init];
    _layout = layout;
    layout.headerReferenceSize = CGSizeZero;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //layout.itemSize = CGSizeMake(kSCREENWIDTH*0.7, (kSCREENHEIGHT)*0.8);
    
    _myCollectionView.collectionViewLayout = layout;
    _myCollectionView.showsVerticalScrollIndicator = NO;
    _myCollectionView.showsHorizontalScrollIndicator = NO;
    _myCollectionView.pagingEnabled = YES;
    [_myCollectionView registerNib:[UINib nibWithNibName:kCustomCollectionViewCell bundle:nil] forCellWithReuseIdentifier:kCustomCollectionViewCell];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arr.count * 2;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell=nil;
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCustomCollectionViewCell forIndexPath:indexPath];
    cell.label.text = _arr[indexPath.item % self.arr.count];

    return cell;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //获取当前CollectionView的偏移量
    CGFloat offSetX = scrollView.contentOffset.x;
    /*
     拿总长度为4 举例:
     初始时,让索引为4的Item为默认显示的Item(第2组第1张)
     当偏移量等于0时(第1组第1张,也就是第一张图片),以无动画的方式悄悄的跳转回索引为4的Item(第2组第1张)
     当偏移量等于7倍CollectionView的宽度时(第2组第4张,也就是最后一张图片),同样以无动画的方式跳转回索引为3的Item(第1组第4张)
     因为两组图片是一致的,又是以无动画无察觉的方式跳转的,所以就可以实现无限轮播的效果了
     */
    if (offSetX == 0) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.arr.count inSection:0];
        
        [self.myCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
    }else if (offSetX == scrollView.bounds.size.width * ( self.arr.count * 2 - 1 )){
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.arr.count - 1 inSection:0];
        
        [self.myCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//配置cell居中
-(void)fixCellToCenter
{
    //最小滚动距离
    float dragMiniDistance = self.view.bounds.size.width/20.0f;
    if (_dragStartX -  _dragEndX >= dragMiniDistance) {
        _currentIndex -= 1;//向右
    }else if(_dragEndX -  _dragStartX >= dragMiniDistance){
        _currentIndex += 1;//向左
    }
    NSInteger maxIndex = [_myCollectionView numberOfItemsInSection:0] - 1;
    _currentIndex = _currentIndex <= 0 ? 0 : _currentIndex;
    _currentIndex = _currentIndex >= maxIndex ? maxIndex : _currentIndex;
    
    [self scrollToCenter];
}
-(void)scrollToCenter
{
    [_myCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    
}

//手指拖动开始
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _dragStartX = scrollView.contentOffset.x;
}

//手指拖动停止
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _currentIndex = indexPath.row;
    [self scrollToCenter];
}

//卡片宽度
-(CGFloat)cellWidth
{
    return self.view.bounds.size.width * CardWidthScale;
}

//卡片间隔
-(float)cellMargin
{
    return (self.view.bounds.size.width - [self cellWidth])/4;
}

//设置左右缩进
-(CGFloat)collectionInset
{
    return self.view.bounds.size.width/2.0f - [self cellWidth]/2.0f;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, [self collectionInset], 0, [self collectionInset]);
}


@end
