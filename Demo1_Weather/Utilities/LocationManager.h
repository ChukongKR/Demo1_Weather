//
//  LocationManager.h
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/18.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationBlock)(CLLocation *location);

@interface LocationManager : NSObject<CLLocationManagerDelegate>

+ (void)getUserLocationWithCompletionHandler:(LocationBlock)locationBlock;

@end
