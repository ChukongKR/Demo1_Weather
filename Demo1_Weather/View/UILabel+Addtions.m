//
//  UILabel+Addtions.m
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/18.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "UILabel+Addtions.h"

@implementation UILabel (Addtions)

+ (instancetype)labelWithFrame:(CGRect)frame {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = 0;
    label.font = [UIFont fontWithName:@"HelveticaNenu-Light" size:30];
    label.textColor = [UIColor whiteColor];
    
    return label;
}

@end
