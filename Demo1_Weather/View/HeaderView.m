//
//  HeaderView.m
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/16.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "HeaderView.h"
#import "UILabel+Addtions.h"
#import "MJRefresh.h"

@implementation HeaderView

//边界
static CGFloat inset = 20;
//Label height width
static CGFloat labelHeight = 40;
static CGFloat labelWidth = 40;
//温度Label
static CGFloat  temperatureLabelHeight = 110;
static CGFloat  temperatureLabelWidth = 110;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //button frame
        CGRect frame = CGRectMake(inset, inset, labelWidth, labelHeight);
        self.menuButton = [[UIButton alloc] init];
        self.menuButton.frame = frame;
        [self.menuButton setImage:[UIImage imageNamed:@"IconHome"] forState:UIControlStateNormal];
        [self addSubview:self.menuButton];
        
        //Title Label
        frame = CGRectMake(self.menuButton.frame.origin.x + labelWidth + 8, inset, labelWidth*3, labelHeight);
        self.titleLabel = [UILabel labelWithFrame:frame];
        [self addSubview:self.titleLabel];
        //TempLabel
        frame = CGRectMake(inset, self.mj_h - labelHeight, labelWidth*2, labelHeight);
        self.tempLabel = [UILabel labelWithFrame:frame];
        [self addSubview:self.tempLabel];
        //CurrentTempLabel
        frame = CGRectMake(inset, self.tempLabel.mj_y - temperatureLabelHeight, temperatureLabelWidth, temperatureLabelHeight);
        self.currentTempLabel = [UILabel labelWithFrame:frame];
        self.currentTempLabel.font = [UIFont systemFontOfSize:80];
        [self addSubview:self.currentTempLabel];
        //ConImageView
        frame = CGRectMake(inset, self.currentTempLabel.mj_y - labelHeight, labelWidth, labelHeight);
        self.conImageView = [[UIImageView alloc] initWithFrame:frame];
        self.conImageView.layer.cornerRadius = 5;
        [self.conImageView clipsToBounds];
        [self addSubview:self.conImageView];
        //ConditionLabel
        frame = CGRectMake(inset + labelWidth + 8, self.currentTempLabel.mj_y - labelHeight, labelWidth*3, labelHeight);
        self.conditionLabel = [UILabel labelWithFrame:frame];
        [self addSubview:self.conditionLabel];
    }
    return self;
}



@end
