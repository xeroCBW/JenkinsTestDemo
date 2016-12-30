//
//  LocationViewController.m
//  JenkinsTestDemo
//
//  Created by 陈博文 on 16/12/30.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "LocationViewController.h"
 #import <CoreLocation/CoreLocation.h>
#import "ReverseGeologyTool.h"


@interface LocationViewController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *locationTextView;


@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong)NSNumber *longitute;
@property (nonatomic, strong)NSNumber *latitude;


@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // !!!: 这个只是简单的使用,更多使用查看 QD 项目
    

}

- (IBAction)startLocationService:(id)sender {
    
    [self startLocation];
    
}


#pragma mark Location and Delegate
- (void)startLocation
{
    
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        NSLog(@"requestWhenInUseAuthorization");
        [self.locationManager requestWhenInUseAuthorization];
//        [self.locationManager requestAlwaysAuthorization];
    }
    
    
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];
    NSLog(@"start gps");
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    
    self.longitute = [NSNumber numberWithDouble:coordinate.longitude];
    self.latitude = [NSNumber numberWithDouble:coordinate.latitude];
    
    // 2.停止定位
    [manager stopUpdatingLocation];
    
    
    [ReverseGeologyTool getLocationInfoWithLocationCordinate2D:coordinate completionHandler:^(NSString *locationName) {
        
        self.locationTextView.text = locationName;
        
    }];

}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    
    NSLog(@"%@",error);
    
    
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
        NSLog(@"用户拒绝");
        [self showAlertView];
        
    }else if (error.code == kCLErrorRegionMonitoringDenied){
        
        NSLog(@"用户拒绝一直监听");
        [self showAlertView];
    }else{
        
        NSLog(@"获取失败");
    }
}


- (void)showAlertView{
    
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"你的定位功能被禁用,如需使用定位功能需到设置中心开启" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:UIApplicationOpenSettingsURLString]];

    }];
    [vc addAction:yes];
    
    [self presentViewController:vc animated:yes completion:nil];
    
}

//typedef NS_ENUM(NSInteger, CLError) {
//    kCLErrorLocationUnknown  = 0,         // location is currently unknown, but CL will keep trying
//    kCLErrorDenied,                       // Access to location or ranging has been denied by the user
//    kCLErrorNetwork,                      // general, network-related error
//    kCLErrorHeadingFailure,               // heading could not be determined
//    kCLErrorRegionMonitoringDenied,       // Location region monitoring has been denied by the user
//    kCLErrorRegionMonitoringFailure,      // A registered region cannot be monitored
//    kCLErrorRegionMonitoringSetupDelayed, // CL could not immediately initialize region monitoring
//    kCLErrorRegionMonitoringResponseDelayed, // While events for this fence will be delivered, delivery will not occur immediately
//    kCLErrorGeocodeFoundNoResult,         // A geocode request yielded no result
//    kCLErrorGeocodeFoundPartialResult,    // A geocode request yielded a partial result
//    kCLErrorGeocodeCanceled,              // A geocode request was cancelled
//    kCLErrorDeferredFailed,               // Deferred mode failed
//    kCLErrorDeferredNotUpdatingLocation,  // Deferred mode failed because location updates disabled or paused
//    kCLErrorDeferredAccuracyTooLow,       // Deferred mode not supported for the requested accuracy
//    kCLErrorDeferredDistanceFiltered,     // Deferred mode does not support distance filters
//    kCLErrorDeferredCanceled,             // Deferred mode request canceled a previous request
//    kCLErrorRangingUnavailable,           // Ranging cannot be performed
//    kCLErrorRangingFailure,               // General ranging failure
//};

#pragma mark - lazy

-(CLLocationManager *)locationManager{
    
    if (_locationManager == nil) {
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

@end
