//
//  AccountViewController.m
//  Tìm kiếm bệnh viện
//
//  Created by Kiet on 9/8/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "AccountViewController.h"
#import "ChangePasswordViewController.h"
#import "BaseNavigationController.h"
#import "UserDataManager.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tài khoản";
    [self showMenuButtonItem];

    
    self.userNameLabel.text =  [UserDataManager sharedClient].fullName; /// Getter, lấy ra giá trị của UserDataManager.
    self.userEmailLabel.text =  [UserDataManager sharedClient].email;
    self.userCityLabel.text =  [UserDataManager sharedClient].city;
}

- (void)viewWillAppear:(BOOL)animated {
    self.userImageView.layer.cornerRadius = 90.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)changePasswordButtonAction:(UIButton *)sender {
    ChangePasswordViewController *view = (ChangePasswordViewController *)[ChangePasswordViewController instanceFromStoryboardName:@"Home"];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:view];
    [self presentViewController:nav animated:true completion:nil];
}

@end
