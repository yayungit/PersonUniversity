//
//  AutoLayoutViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/7.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "AutoLayoutViewController.h"
#import "AutoTestTableViewCell.h"
#import "CustomAutoTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>


@interface AutoLayoutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *autoTableView;
@property (weak, nonatomic) IBOutlet UILabel *scaleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scaleLabelHeight;

@end

static NSString *const kAutoTestTableViewCell = @"AutoTestTableViewCell";
static NSString *const kCustomAutoTableViewCell = @"CustomAutoTableViewCell";

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share"]];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    [_autoTableView registerNib:[UINib nibWithNibName:kAutoTestTableViewCell bundle:nil] forCellReuseIdentifier: kAutoTestTableViewCell];
    [_autoTableView registerNib:[UINib nibWithNibName:kCustomAutoTableViewCell bundle:nil] forCellReuseIdentifier:kCustomAutoTableViewCell];
    
    _scaleLabel.font = [UIFont cwFontWithSize:20];
    _scaleLabelHeight.constant = _scaleLabelHeight.constant * [UIView scaleFromeIphone6];
    
}
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
}

//iPhone4S,iPhone5/5s,iPhone6
//竖屏：(w:Compact h:Regular)
//横屏：(w:Compact h:Compact)
//iPhone6 Plus
//竖屏：(w:Compact h:Regular)
//横屏：(w:Regular h:Compact)
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        // 现在的 iPad 不论横屏还是竖屏，两个方向均是 Regular 的；而对于 iPhone，竖屏时竖直方向为 Regular，水平方向是 Compact，而在横屏时两个方向都是 Compact
        if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
            
        } else {
            
        }
    } completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 2) {
        CustomAutoTableViewCell *customcell = [tableView dequeueReusableCellWithIdentifier:kCustomAutoTableViewCell forIndexPath:indexPath];
        return customcell;
    } else {
        AutoTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAutoTestTableViewCell forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
//        CustomAutoTableViewCell *cellCustom = [[NSBundle mainBundle]loadNibNamed:kCustomAutoTableViewCell owner:self options:nil].lastObject;
//        CGSize size = [cellCustom.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//       return  [tableView fd_heightForCellWithIdentifier:kCustomAutoTableViewCell cacheByIndexPath:indexPath configuration:^(id cell) {
//            // 配置cell的数据源
//        }];
        return [tableView fd_heightForCellWithIdentifier:kCustomAutoTableViewCell configuration:^(id cell) {
            
        }];
        
//        return size.height;
        
    } else {
        // 100是正常的高度， 减去缩放后的差  , 10是cell最下方的间隔
        AutoTestTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:kAutoTestTableViewCell owner:self options:nil].firstObject;
        return cell.rowHeight>0 ? cell.rowHeight:0;
    }
    
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
