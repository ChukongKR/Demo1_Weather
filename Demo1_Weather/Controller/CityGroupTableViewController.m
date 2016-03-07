//
//  CityGroupTableViewController.m
//  Demo1_Weather
//
//  Created by 郭正豪 on 16/1/16.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "CityGroupTableViewController.h"
#import "DataManager.h"
#import "CityGroup.h"
@interface CityGroupTableViewController ()
@property (strong, nonatomic) NSMutableArray<CityGroup *> *cityGroupArray;
@property (strong, nonatomic) DataManager *manager;
@end

static NSString *identifier = @"Cell";
@implementation CityGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市列表";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

- (NSMutableArray *)cityGroupArray {
    if (!_cityGroupArray) {
        _cityGroupArray = [[DataManager dataArrayFromPlist] copy];
    }
    return _cityGroupArray;
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.cityGroupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.cityGroupArray[section].cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = self.cityGroupArray[indexPath.section].cities[indexPath.row];
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return [self.cityGroupArray valueForKeyPath:@"title"];
}

#pragma mark - TableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.cityGroupArray[section].title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CityGroup *cityGroup = self.cityGroupArray[indexPath.section];
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidChangeCity" object:@{@"CityName":cityGroup.cities[indexPath.row]}];
    }];
}

@end
