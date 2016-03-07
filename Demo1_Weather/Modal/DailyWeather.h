//
//  DailyWeather.h
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/18.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyWeather : NSObject

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *maxtempC;
@property (strong, nonatomic) NSString *mintempC;
@property (strong, nonatomic) NSString *imageURL;

+ (instancetype)parseDailyWithJson:(NSDictionary *)dict;

@property (strong, nonatomic) NSString *currentTemp;
@property (strong, nonatomic) NSString *weatherDesc;

+ (instancetype)parseCurrentWithJson:(NSDictionary *)dict;

@end
