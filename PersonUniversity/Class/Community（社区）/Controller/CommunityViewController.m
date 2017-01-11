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
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearchOption.h>
@interface CommunityViewController ()<BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,BMKMapViewDelegate>

@property (nonatomic, strong) BMKLocationService *bmService; //定位
@property (nonatomic, strong) BMKGeoCodeSearch *bmCodeDearch;//地理编码主类，用来查询、返回结果信息
@property (nonatomic, strong) BMKMapView *bmMapView;


@end

@implementation CommunityViewController

//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [_bmMapView viewWillAppear];
//    _bmMapView.delegate = self;
//}
//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [_bmMapView viewWillDisappear];
//    _bmMapView.delegate = nil;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Community";
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view from its nib.
    _bmCodeDearch = [[BMKGeoCodeSearch alloc] init];
    _bmCodeDearch.delegate = self;
    [self startLoaction];
    // 地图
//    _bmMapView = [[BMKMapView alloc] init];
//    self.view = _bmMapView;
    
    [self configUI];
    
}


- (void)configUI {
    UIButton *reverseGeoCode = [UIButton buttonWithType:UIButtonTypeSystem];
    reverseGeoCode.frame  = CGRectMake(200, 100, 100, 40);
    [reverseGeoCode setTitle:@"反地理编码" forState:(UIControlStateNormal)];
    [reverseGeoCode addTarget:self action:@selector(reverseGeoCode:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:reverseGeoCode];
    
    UIButton *getcode = [UIButton buttonWithType:UIButtonTypeSystem];
    getcode.frame  = CGRectMake(200, 200, 100, 40);
    [getcode setTitle:@"获取经纬度" forState:(UIControlStateNormal)];
    [getcode addTarget:self action:@selector(getcode:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:getcode];
}
// 反地理编码，根据经纬度获取地理信息
- (void)reverseGeoCode:(UIButton *)btn {
    double lat = _bmService.userLocation.location.coordinate.latitude;
    double lng = _bmService.userLocation.location.coordinate.longitude;
    [self.bmService stopUserLocationService];
    self.bmService.delegate = nil;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){lat,lng};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    bool flag = NO;
    flag = [self.bmCodeDearch reverseGeoCode:reverseGeoCodeSearchOption];
}
// 根据地理位置获取经纬度
- (void)getcode:(UIButton *)btn {
    [self.bmService stopUserLocationService];
    self.bmService.delegate = nil;
    BMKGeoCodeSearchOption *geoCodeSearchOptio = [[BMKGeoCodeSearchOption alloc] init];
    geoCodeSearchOptio.address = @"河南省商丘市夏邑县";
    geoCodeSearchOptio.city = @"河南";
    bool flag = NO;
    flag = [self.bmCodeDearch geoCode:geoCodeSearchOptio];

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
//    double lat = userLocation.location.coordinate.latitude;
//    double lng = userLocation.location.coordinate.longitude;
//    [self.bmService stopUserLocationService];
//    self.bmService.delegate = nil;
//    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){lat,lng};
//    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
//    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
//    bool flag = NO;
//    flag = [self.bmCodeDearch reverseGeoCode:reverseGeoCodeSearchOption];

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
    if (error == 0) {
        NSString* titleStr;
        NSString* showmeg;
        titleStr = @"获取经纬度";
        showmeg = [NSString stringWithFormat:@"%f",_bmService.userLocation.location.coordinate.latitude];
        YYLog(@"纬度---%f,经度--%f",_bmService.userLocation.location.coordinate.latitude,_bmService.userLocation.location.coordinate.longitude);
        
//        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
//        [myAlertView show];
    }
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        NSString* titleStr;
        NSString* showmeg;
        titleStr = @"反向地理编码";
        showmeg = [NSString stringWithFormat:@"%@",item.title];
        YYLog(@"subtitle====%@", item.subtitle);
//        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
//        [myAlertView show];
    }
}


@end
