//
//  SearchResultViewController.m
//  BenhVien-app
//
//  Created by test on 7/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SearchResultViewController.h"


@interface SearchResultViewController()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SearchResultViewController
@synthesize hospitals;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Kết quả";
    self.searchResultTableView.delegate = self;
    self.searchResultTableView.dataSource = self;
    // Bỏ các các dòng ở dưới nếu hết nội dung.
    self.searchResultTableView.tableFooterView = [UIView new];
    
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.hospitals) {
        [self.searchResultTableView reloadData];
    }
}

- (void)setTableView:(NSArray *)hospitalsArray {
    self.hospitals = hospitals;
        [self.searchResultTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    [self showBackButtonItem];
    self.searchResultTableView.estimatedRowHeight = 91.0;
}

#pragma mark Table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hospitals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[HospitalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Hospital *hospital = self.hospitals[indexPath.row];
    [cell setDataForCell:hospital];

    return cell;
}

#pragma mark table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
    DetailsViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    view.currentHospital = self.hospitals[indexPath.row];
    [self.navigationController pushViewController:view animated:true];
}


@end






















