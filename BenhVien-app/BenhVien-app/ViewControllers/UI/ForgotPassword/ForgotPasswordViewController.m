//
//  ForgotPasswordViewController.m
//  Tìm kiếm bệnh viện
//
//  Created by Kiet on 9/11/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "BaseNavigationController.h"
#import "UIAlertController+Blocks.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _activatingButton.layer.cornerRadius = 5.0;
    self.title = @"Quên mật khẩu";
    [self showRightBarButtonItemWithTittle:@"Huỷ"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)rightBarButtonAction:(id)sender {
    [self.view endEditing: true];
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)codeSendingAction:(UIButton *)sender {
    [self showAlertWithTitle:@"Lou" message:@"Này chưa có làm má ôi!"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}


@end









