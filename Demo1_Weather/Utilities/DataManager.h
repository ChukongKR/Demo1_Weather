//
//  DataManager.h
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/16.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DataManager : NSObject


+ (NSArray *)dataArrayFromPlist;
+ (NSArray *)dailyDataFromObject:(id)responseObject;
+ (NSArray *)hourlyDataFromObject:(id)responseObject;

@end
