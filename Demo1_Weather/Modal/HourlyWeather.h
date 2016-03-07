//
//  HourlyWeather.h
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/18.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HourlyWeather : NSObject

@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *tempC;
@property (strong, nonatomic) NSString *weatherIconUrl;

+ (instancetype)hourlyWeatherDataWithJson:(NSDictionary *)dict;

@end
