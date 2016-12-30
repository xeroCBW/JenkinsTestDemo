//
//  ReverseGeologyTool.m
//  JenkinsTestDemo
//
//  Created by 陈博文 on 16/12/30.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "ReverseGeologyTool.h"


@implementation ReverseGeologyTool


+ (void)getLocationInfoWithLocationCordinate2D:(CLLocationCoordinate2D )locationCoordinate2D completionHandler:(reverseGeocodeLocationBlock)completionHandler
{
    __block NSString *locationName = @"";
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:locationCoordinate2D.latitude longitude:locationCoordinate2D.longitude];
    NSLog(@"latitude->%f, longitude->%f",locationCoordinate2D.latitude,locationCoordinate2D.longitude);
    
    [[[CLGeocoder alloc]init] reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error || placemarks.count == 0) {
            
            NSLog(@"暂时没有办法获取地理位置");
            //暂时没有办法获取地理位置
            locationName = @"暂时没有办法获取地理位置";
            completionHandler(locationName);
        }
        else {
            CLPlacemark *placemark = [placemarks firstObject];
            NSLog(@"-->%@", placemark.name);
            //获取到地理位置
            NSLog(@"获取到地理位置");
            locationName = placemark.name;
            completionHandler(locationName);
        }
        
    }];
}

@end
