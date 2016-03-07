//
//  MainWeatherViewController.m
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/16.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "MainWeatherViewController.h"
#import "HeaderView.h"
#import "RESideMenu.h"
#import "LocationManager.h"
#import "NetworkingManager.h"
#import "TSMessage.h"
#import "MJRefresh.h"
#import "UILabel+Addtions.h"
#import "DailyWeather.h"
#import "DataManager.h"
#import "HourlyWeather.h"
#import "UIImageView+WebCache.h"
#import "NSString+Addtions.h"
@interface MainWeatherViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) HeaderView *headerView;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) NSArray<DailyWeather *> *weahterArray;
@property (strong, nonatomic) NSArray<NSArray<HourlyWeather *> *> *hourlyWeatherArray;
@property (strong, nonatomic) NSString *weatherURL;
@property (strong, nonatomic) CLGeocoder *geoCoder;
@property (strong, nonatomic) DailyWeather *currentWeather;
@end

@implementation MainWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCity:) name:@"DidChangeCity" object:nil];
    
    [LocationManager getUserLocationWithCompletionHandler:^(CLLocation *location) {
        self.currentLocation = location;
        [self getLocationAndSendRequest];
        [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (!error) {
                self.headerView.titleLabel.text = [placemarks firstObject].addressDictionary[@"City"];
            }
        }];
    }];
    
    [self createTableView];
    [self createHeaderView];
}

- (void)createHeaderView {
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:SCREEN_BOUNDS];
    self.headerView = headerView;
    [headerView.menuButton addTarget:self action:@selector(showLeftVC:) forControlEvents:UIControlEventTouchUpInside];
    headerView.titleLabel.text = @"Loading...";
    self.tableView.tableHeaderView = headerView;
}

- (void)createBackgroundView {
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MenuBackground"]];
    backgroundView.frame = SCREEN_BOUNDS;
    
    [self.view addSubview:backgroundView];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.pagingEnabled = YES;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh:)];
    
    [self.view addSubview:self.tableView];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Notification
- (void)changeCity:(NSNotification *)notification {
    [self.sideMenuViewController hideMenuViewController];
    [self.geoCoder geocodeAddressString:notification.object[@"CityName"] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        self.currentLocation = [placemarks firstObject].location;
        [self getLocationAndSendRequest];
        self.headerView.titleLabel.text = [notification.object[@"CityName"] transformToPinyin];
    }];
}

#pragma mark - LazyInitialization
- (CLGeocoder *)geoCoder {
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
}

#pragma mark - privateMethods
- (void)updateHeaderView {
    self.headerView.conditionLabel.text = self.currentWeather.weatherDesc;
    self.headerView.currentTempLabel.text = [NSString stringWithFormat:@"%@°", self.currentWeather.currentTemp];
    self.headerView.tempLabel.text = [NSString stringWithFormat:@"%@° / %@°", self.currentWeather.mintempC, self.currentWeather.maxtempC];
    [self.headerView.conImageView sd_setImageWithURL:[NSURL URLWithString:self.currentWeather.imageURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}


- (void)showLeftVC:(UIButton *)sender {
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (void)getLocationAndSendRequest {
    self.weatherURL = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v2/weather.ashx?q=%f,%f&num_of_days=5&format=json&key=654cd643251f5a391b6e10b8fdbef", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude];
    
    [NetworkingManager getRequestWithAFNetworking:[NSURL URLWithString:self.weatherURL] parameters:nil success:^(id responseObject) {
        [TSMessage showNotificationWithTitle:@"请求成功" subtitle:nil type:TSMessageNotificationTypeSuccess];
        self.weahterArray = [DataManager dailyDataFromObject:responseObject];
        self.hourlyWeatherArray = [DataManager hourlyDataFromObject:responseObject];
        self.currentWeather = [DailyWeather parseCurrentWithJson:responseObject];
        [self updateHeaderView];
        [self.tableView reloadData];
         } failure:^(NSError *error) {
        NSLog(@"%@", error.userInfo);
        [TSMessage showNotificationWithTitle:@"请求失败" subtitle:@"请稍后再试" type:TSMessageNotificationTypeWarning];
    }];
}

- (void)refresh:(MJRefreshNormalHeader *)header {
    
    
    
    [self.tableView reloadData];
    
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.hourlyWeatherArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hourlyWeatherArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.imageView.layer.cornerRadius = 5;
    cell.imageView.clipsToBounds = YES;
    cell.imageView.image = [UIImage imageNamed:@"placeholder"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.hourlyWeatherArray[indexPath.section][indexPath.row].weatherIconUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData:data];
        });
    });
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, 40)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *datelabel = [UILabel labelWithFrame:CGRectMake(8, 25, self.view.mj_w, 15)];
    datelabel.text = self.weahterArray[section].date;
    datelabel.backgroundColor = [UIColor clearColor];
    
    UILabel *tempLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_BOUNDS.size.width - 100, 25, 80, 15)];
    tempLabel.text = [NSString stringWithFormat:@"%@°/ %@°",self.weahterArray[section].mintempC,self.weahterArray[section].maxtempC];
    tempLabel.textAlignment = 2;
    [view addSubview:datelabel];
    [view addSubview:tempLabel];
    return view;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (SCREEN_BOUNDS.size.height - 40)/self.hourlyWeatherArray[indexPath.section].count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.textLabel.text = self.hourlyWeatherArray[indexPath.section][indexPath.row].time;
    cell.detailTextLabel.text = self.hourlyWeatherArray[indexPath.section][indexPath.row].tempC;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


@end