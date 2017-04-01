//
//  CollectionViewItemCanMoveAndDeleteViewController.m
//  PersonUniversity
//
//  Created by YYSky--Star✨--🦂️ on 2017/3/29.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "CollectionViewItemCanMoveAndDeleteViewController.h"
#import "MoveAndDeleteCollectionViewCell.h"
@interface CollectionViewItemCanMoveAndDeleteViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

static NSString *const kMoveAndDeleteCollectionViewCell = @"MoveAndDeleteCollectionViewCell";

@implementation CollectionViewItemCanMoveAndDeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(kSCREENWIDTH/3-40, 80);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[MoveAndDeleteCollectionViewCell class] forCellWithReuseIdentifier:kMoveAndDeleteCollectionViewCell];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    __weak MoveAndDeleteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMoveAndDeleteCollectionViewCell forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor colorWithRed:(arc4random()%255) /255.0 green:(arc4random()%255) /255.0 blue:(arc4random()%255) /255.0 alpha:1];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.label.text = _dataArr[indexPath.row];
    [cell addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveItem:)]];
    [cell addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteGes:)]];
    if (_isDelete == YES) {
        cell.deleteButton.hidden = NO;
    } else {
        cell.deleteButton.hidden = YES;
    }
    cell.deleteBlock = ^(CGPoint point) {
        NSIndexPath *index = [self.collectionView indexPathForItemAtPoint:point];
        [_dataArr removeObjectAtIndex:index.row];
        [self.collectionView deleteItemsAtIndexPaths:@[index]];
    };
    
    return cell;
}



- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    id obj = [_dataArr objectAtIndex:sourceIndexPath.row];
    [_dataArr removeObjectAtIndex:sourceIndexPath.row];
    [_dataArr insertObject:obj atIndex:destinationIndexPath.row];
}
- (void)deleteGes:(UILongPressGestureRecognizer *)ges {
    _isDelete = YES;
    [self.collectionView reloadData];    
}


- (void)moveItem:(UIPanGestureRecognizer *)pan {
    CGPoint originPoint = [pan locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:originPoint];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        case UIGestureRecognizerStateChanged:
            [self.collectionView updateInteractiveMovementTargetPosition:[pan locationInView:self.collectionView]];
            break;
        default:
            break;
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self.collectionView endInteractiveMovement];
        
    }
    
}







@end
