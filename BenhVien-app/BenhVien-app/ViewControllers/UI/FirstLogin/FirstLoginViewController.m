//
//  FirstLoginViewController.m
//  Tìm kiếm bệnh viện
//
//  Created by Kiet on 9/4/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "FirstLoginViewController.h"
#import "SignUpViewController.h"
#import "BaseNavigationController.h"
#import "ApiRequest.h"
#import "ApiResponse.h"

@interface FirstLoginViewController ()

@end

@implementation FirstLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
}

- (IBAction)EmailLoginAction:(UIButton *)sender {
    SignUpViewController *view = (SignUpViewController *)[SignUpViewController instanceFromStoryboardName:@"Login"];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController: view];
    [self presentViewController: nav animated:true completion: nil];
}

@end
