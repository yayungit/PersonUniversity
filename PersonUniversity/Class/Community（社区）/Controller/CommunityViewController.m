//
//  CommunityViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 2016/11/25.
//  Copyright © 2016年 YYStar. All rights reserved.
//

#import "CommunityViewController.h"
#import<BaiduMapAPI_Location/BMKLocationService.h>

#import<BaiduMapAPI_Search/BMKGeocodeSearch.h>
@interface CommunityViewController ()<BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>

@property (nonatomic, strong) BMKLocationService *bmService; //定位
@property (nonatomic, strong) BMKGeoCodeSearch *bmCodeDearch;//地理编码主类，用来查询、返回结果信息

@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Community";
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view from its nib.
    _bmCodeDearch = [[BMKGeoCodeSearch alloc] init];
    _bmCodeDearch.delegate = self;
    [self startLoaction];
}
- (void)startLoaction {
    _bmService = [[BMKLocationService alloc] init];
    _bmService.delegate = self;
    _bmService.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [_bmService startUserLocationService];
}

#pragma mark - BMKLocationServiceDelegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - BMKGeoCodeSearchDelegate
/**
 *返回地址信息搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结BMKGeoCodeSearch果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
