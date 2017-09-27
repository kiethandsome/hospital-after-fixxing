//
//  SearchResultViewController.m
//  BenhVien-app
//
//  Created by test on 7/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SearchResultViewController.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import "ApiRequest.h"


@interface SearchResultViewController()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SearchResultViewController
@synthesize hospitals;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Kết quả";
    self.searchResultTableView.delegate = self;
    self.searchResultTableView.dataSource = self;

    self.currentPage = 1;
    
    //  Adding pull to refresh.
    __weak SearchResultViewController *wSelf = self;
    [self.searchResultTableView addPullToRefreshWithActionHandler:^{
        if (wSelf.type == HOME) {
            
        }
        if (wSelf.type == CITY) {
            [wSelf refreshCity];
        }
        if (wSelf.type == DISTRICT) {
            [wSelf refreshDistrict];
        }
    }];
    
    //  Adding Infinite Scrollling.
    [self.searchResultTableView addInfiniteScrollingWithActionHandler:^{
        if (wSelf.type == HOME) {
            
        }
        if (wSelf.type == CITY) {
            [self loadMoreCity];
        }
        if (wSelf.type == DISTRICT) {
            [wSelf loadMoreDistrict];
        }
    }];
    self.searchResultTableView.pullToRefreshView.arrowColor = [UIColor redColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    [self showBackButtonItem];
    if (self.hospitals) {
        [self.searchResultTableView reloadData];
    }
    self.searchResultTableView.estimatedRowHeight = 91.0;
    self.searchResultTableView.tableFooterView = [UIView new];

}

#pragma mark - Refresh

- (void)refreshCity {
    if (self.totalPage == 1) {
        
    }
    self.searchResultTableView.showsInfiniteScrolling = YES;
    [self searchHospitalByCityName:_city totalPages:1 loadMode:REFRESH];
    self.currentPage = 1;
}

- (void)refreshDistrict {
    if (self.totalPage == 1) {
        
    }
    self.searchResultTableView.showsInfiniteScrolling = YES;
    [self searchHospitalByCityName:_city district:_district totalPages:1 loadMode:REFRESH];
    self.currentPage = 1;
}

#pragma mark - Load more.

- (void)loadMoreCity {
    if (self.currentPage == _totalPage) {
        [self.searchResultTableView.infiniteScrollingView stopAnimating];
    } else {
        [self searchHospitalByCityName:self.city totalPages:_currentPage +1 loadMode:LOADMORE];
        _currentPage += 1;
    }
}

- (void)loadMoreDistrict {
    if (self.currentPage == _totalPage) {
        [self.searchResultTableView.infiniteScrollingView stopAnimating];
    } else {
        [self searchHospitalByCityName:_city district:_district totalPages:_currentPage +1 loadMode:LOADMORE];
        _currentPage += 1;
    }
}

#pragma mark - Display data.

- (void)displayData:(NSMutableArray *)data loadMode:(LoadMode)loadMode {
    if (loadMode == REFRESH) {
        [self.hospitals removeAllObjects];
        self.hospitals = data;
        [self.searchResultTableView reloadData];
        [self.searchResultTableView.pullToRefreshView stopAnimating];
    }
    if (loadMode == LOADMORE) {
        [self.hospitals addObjectsFromArray:data];
        [self.searchResultTableView reloadData];
        [self.searchResultTableView.infiniteScrollingView stopAnimating];
    }
}



#pragma mark - Table view delegate and Data sources

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    view.currentHospital = self.hospitals[indexPath.row];
    [self.navigationController pushViewController:view animated:true];
}


#pragma mark - Search By The CITY and DISTRICT Name

- (void)searchHospitalByCityName:(NSString *)cityName district:(NSString *)districtName totalPages:(NSInteger)pages loadMode:(LoadMode)loadMode {
    [ApiRequest searchTheHospitalByCityName:cityName
                                   district:districtName
                                       page:pages
                                 completion:^(ApiResponse *response, NSError *error)
    {
        NSArray *hospitalArray = [response.data objectForKey:@"hospitals"];
        if (hospitalArray > 0)
        {
            NSMutableArray *hosArray = [NSMutableArray new];
            for (NSDictionary *dict in hospitalArray)
            {
                Hospital *aHospital = [Hospital initWithResponse:dict];
                [hosArray addObject:aHospital];
            }
            __weak SearchResultViewController *wSelf = self;
            [wSelf displayData:hosArray loadMode:loadMode];
        } else
        {
            [self showAlertWithTitle:@"Thông báo" message:@"Không tìm thấy bệnh viện bạn yêu cầu!"];
        }
    }];
}

#pragma mark - Seacrh by City Name.

- (void)searchHospitalByCityName:(NSString *)cityName totalPages:(NSInteger)pages loadMode:(LoadMode)loadMode {
    [ApiRequest searchTheHospitalByTheCityName:cityName page:pages completion:^(ApiResponse *response, NSError *error) {
        NSArray *hospitalArray = [response.data valueForKey:@"hospitals"];
        if (hospitalArray > 0) {
            NSMutableArray *hosArray = [NSMutableArray new];
            for (NSDictionary *dict in hospitalArray) {
                Hospital *aHospital = [Hospital initWithResponse:dict];
                [hosArray addObject:aHospital];
            }
            __weak SearchResultViewController *wSelf = self;
            [wSelf displayData:hosArray loadMode:loadMode];
        }else {
            [self showAlertWithTitle:@"Thông đít" message:@"Không tìm thấy bệnh viện bạn yêu cầu!"];
        }
    }];
}


@end






















