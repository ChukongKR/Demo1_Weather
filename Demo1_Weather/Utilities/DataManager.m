//
//  DataManager.m
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/16.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "DataManager.h"
#import "CityGroup.h"
#import "DailyWeather.h"
#import "HourlyWeather.h"
@implementation DataManager

static NSMutableArray *_cityData = nil;


+ (NSArray *)dataArrayFromPlist {
    _cityData = [NSMutableArray array];
    NSArray *array = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cityGroups.plist" ofType:nil]];
    for (NSDictionary *dict in array) {
        CityGroup *cityGroup = [CityGroup new];
        cityGroup.title = dict[@"title"];
        cityGroup.cities = dict[@"cities"];
        [_cityData addObject:cityGroup];
    }
    return _cityData;
}

+ (NSArray *)dailyDataFromObject:(id)responseObject {
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSArray *array = responseObject[@"data"][@"weather"];
    for (int i = 0; i < array.count; i++) {
        DailyWeather *dailyWeather = [DailyWeather parseDailyWithJson:array[i]];
        [mutableArray addObject:dailyWeather];
    }
    return [mutableArray copy];
}

+ (NSArray *)hourlyDataFromObject:(id)responseObject {
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSArray *array = responseObject[@"data"][@"weather"];
    for (int i = 0; i < array.count; i++) {
        NSArray *hourlyArray = array[i][@"hourly"];
        NSMutableArray *hourlyMutableArray = [NSMutableArray array];
        for (int j = 0; j< hourlyArray.count; j++) {
            HourlyWeather *hourlyWeather = [HourlyWeather hourlyWeatherDataWithJson:hourlyArray[j]];
            [hourlyMutableArray addObject:hourlyWeather];
        }
        [mutableArray addObject:hourlyMutableArray];
    }
    return [mutableArray copy];
}

@end
