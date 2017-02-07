//
//  AutoLayoutViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/7.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "AutoLayoutViewController.h"
#import "AutoTestTableViewCell.h"
@interface AutoLayoutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *autoTableView;

@end

static NSString *const kAutoTestTableViewCell = @"AutoTestTableViewCell";

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share"]];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    [_autoTableView registerNib:[UINib nibWithNibName:kAutoTestTableViewCell bundle:nil] forCellReuseIdentifier: kAutoTestTableViewCell];
//    _autoTableView.estimatedRowHeight = UITableViewAutomaticDimension;
//    _autoTableView.rowHeight = 10;
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
    AutoTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAutoTestTableViewCell forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 100是正常的高度， 减去缩放后的差  , 10是cell最下方的间隔
//    CGFloat diff = [UIView scaleFromeIphone6];
//    if (diff>1) {
//        return 100+10*diff;
//    } else if (diff < 1) {
//        return 100-10*diff;
//    } else {
//        return 100;
//    }
    AutoTestTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:kAutoTestTableViewCell owner:self options:nil].firstObject;
    return cell.rowHeight>0 ? cell.rowHeight:0;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
