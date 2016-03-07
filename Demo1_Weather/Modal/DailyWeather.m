//
//  DailyWeather.m
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/18.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "DailyWeather.h"

@implementation DailyWeather

+ (instancetype)parseDailyWithJson:(NSDictionary *)dict {
    return [[self alloc] parseDailyWithJson:dict];
}

- (instancetype)parseDailyWithJson:(NSDictionary *)dict {
    self.date = dict[@"date"];
    self.maxtempC = dict[@"maxtempC"];
    self.mintempC = dict[@"mintempC"];
    self.imageURL = dict[@"hourly"][0][@"weatherIconUrl"][0][@"value"];
    
    return self;
}

+ (instancetype)parseCurrentWithJson:(NSDictionary *)dict {
    return [[self alloc] parseCurrentWithJson:dict];
}

- (instancetype)parseCurrentWithJson:(NSDictionary *)dict {
    self.currentTemp = dict[@"data"][@"current_condition"][0][@"temp_C"];
    self.imageURL = dict[@"data"][@"current_condition"][0][@"weatherIconUrl"][0][@"value"];
    self.weatherDesc = dict[@"data"][@"current_condition"][0][@"weatherDesc"][0][@"value"];
    self.maxtempC = dict[@"data"][@"weather"][0][@"maxtempC"];
    self.mintempC = dict[@"data"][@"weather"][0][@"mintempC"];
    return self;
}

@end
