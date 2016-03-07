//
//  HourlyWeather.m
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/18.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "HourlyWeather.h"

@implementation HourlyWeather

+ (instancetype)hourlyWeatherDataWithJson:(NSDictionary *)dict {
    return [[self alloc] hourlyWeatherDataWithJson:dict];
}

- (instancetype)hourlyWeatherDataWithJson:(NSDictionary *)dict {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    NSInteger time = [formatter numberFromString:dict[@"time"]].integerValue;
    self.time = [NSString stringWithFormat:@"%02ld:%02ld", time/100, time%100];
    self.tempC = [NSString stringWithFormat:@"%@°",dict[@"tempC"]];
    self.weatherIconUrl = dict[@"weatherIconUrl"][0][@"value"];
    
    return self;
}

@end
