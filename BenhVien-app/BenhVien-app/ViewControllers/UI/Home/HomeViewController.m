//
//  HomeViewController.m
//  BenhVien-app
//
//  Created by test on 7/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "HomeViewController.h"
#import "UserDataManager.h"

@interface HomeViewController ()

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tìm kiếm";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view endEditing:true];
}

- (void)setUpUserInterface {
    _searchTextField.layer.cornerRadius = 4.0;
    _searchTextField.layer.borderWidth = 0.5;
    _searchTextField.layer.borderColor = [UIColor colorWithHex: 0xC8C7CC].CGColor;

    self.searchButton.layer.cornerRadius = 4.0;
    self.advanceSearchButton.layer.cornerRadius = 4.0;
    
    [self showMenuButtonItem];
}

#pragma mark - Button Pressed.

- (IBAction)advanceSearchBtn:(UIButton *)sender {
    [self.view endEditing:true];

    AdvanceSearchViewController *vc = (AdvanceSearchViewController *)[AdvanceSearchViewController instanceFromStoryboardName:@"Home"];
    vc.prevViewController = self;
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)searchButtonAction:(UIButton *)sender {
    [self.view endEditing:true];

    NSString *hospitalName = self.searchTextField.text;
    [self validateHospitalName:hospitalName completion:^(BOOL isValidated, NSString *message) {
        if (isValidated){
            [self searchHospital:hospitalName];
        }else {
            [self showAlertWithTitle:@"Lỗi" message:message];
        }
    }];
}

#pragma mark - Search HOspital.

- (void)searchHospital:(NSString *)hospitalName {

    [self showHUD];
    [ApiRequest searchHospitalByName:hospitalName completion:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
        if (error){
            [self showAlertWithTitle:@"Lỗi" message:error.description];
        }else {
            NSArray *hospitalsList = [response.data objectForKey:@"hospitals"];
            if (hospitalsList.count <= 0) {
                [self showAlertWithTitle:@"Lỗi" message:@"Không tồn tại bệnh viện mà bạn đang tìm"];
            }else {
                NSMutableArray *hospitalArray = [NSMutableArray new];
                for (NSDictionary *data in hospitalsList) {
                    Hospital *hos = [Hospital initWithResponse:data];
                    [hospitalArray addObject:hos];
                }
                SearchResultViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultViewController"];
                view.hospitals = hospitalArray;
                view.type = HOME;
                [self.navigationController pushViewController:view animated:true];
            }
        }
    }];
}

- (void)validateHospitalName:(NSString *)name completion:(void (^)(BOOL isValidated, NSString *message))completion {
    if (!name || [name isEqualToString: @""]) {
        completion(NO, @"Bạn phải nhập tên bệnh viện");
        return;
    }
    completion(YES, @"");
}

@end
















