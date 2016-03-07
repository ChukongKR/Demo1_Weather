//
//  LeftViewController.m
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/16.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "LeftViewController.h"
#import "CityGroupTableViewController.h"
@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self createBackgroundView];
    [self createTableView];
}

- (void)createBackgroundView {
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Stars"]];
    backgroundView.frame = SCREEN_BOUNDS;
    
    [self.view addSubview:backgroundView];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (SCREEN_BOUNDS.size.height - 100)/2, SCREEN_BOUNDS.size.width - 40, SCREEN_BOUNDS.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    
    [self.view addSubview:self.tableView];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = indexPath.row == 0 ? @"切换城市" : @"其他";
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:indexPath.row == 0 ? @"IconSettings":@"IconProfile"];
    return cell;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CityGroupTableViewController *cgtvc = [CityGroupTableViewController new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cgtvc];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

@end
