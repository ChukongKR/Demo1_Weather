//
//  LocationManager.m
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/18.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "LocationManager.h"
#import <UIKit/UIKit.h>
@interface LocationManager()<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *manager;
@property (copy, nonatomic) LocationBlock block;
@end

@implementation LocationManager

- (instancetype)init {
    if (self = [super init]) {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
            //Info.plist 添加Key
            [self.manager requestWhenInUseAuthorization];
        }
    }
    return self;
}

+ (instancetype)sharedLocationManager {
    static LocationManager *_sharedLocationManager = nil;
    if (!_sharedLocationManager) {
        _sharedLocationManager = [[LocationManager alloc] init];
    }
    return _sharedLocationManager;
}

+ (void)getUserLocationWithCompletionHandler:(LocationBlock)locationBlock {
    LocationManager *locationManager = [self sharedLocationManager];
    locationManager.block = [locationBlock copy];
    [locationManager getUserLocation];
}

- (void)getUserLocation {
    //用户不同意/没有开启定位功能
    if (![CLLocationManager locationServicesEnabled]) {
        //通知无法定位
        return;
    }
    //设置精度
    self.manager.distanceFilter = 500;
    //开始定位
    [self.manager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    self.block([locations lastObject]);
    
    [self.manager stopUpdatingLocation];
}

@end
