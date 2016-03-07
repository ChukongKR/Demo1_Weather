//
//  HeaderView.h
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/16.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView
@property (strong, nonatomic) UIButton *menuButton;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *tempLabel;
@property (strong, nonatomic) UIImageView *conImageView;
@property (strong, nonatomic) UILabel *conditionLabel;
@property (strong, nonatomic) UILabel *currentTempLabel;
@end
