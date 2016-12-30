//
//  ReverseGeologyTool.h
//  JenkinsTestDemo
//
//  Created by 陈博文 on 16/12/30.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


typedef void(^reverseGeocodeLocationBlock)(NSString *);

@interface ReverseGeologyTool : NSObject

+ (void)getLocationInfoWithLocationCordinate2D:(CLLocationCoordinate2D )locationCoordinate2D completionHandler:(reverseGeocodeLocationBlock)completionHandler;

@end
