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
    [UIAlertController showAlertInViewController:self
                                       withTitle:@"Xác nhận"
                                         message:@"bạn chắc chắn muốn huỷ bỏ"
                               cancelButtonTitle:@"Không"
                          destructiveButtonTitle:@"Có"
                               otherButtonTitles:nil
                                        tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                            if (buttonIndex == controller.cancelButtonIndex) {
                                                
                                            } else if (buttonIndex == controller.destructiveButtonIndex) {
                                                [self.navigationController dismissViewControllerAnimated:true completion:nil];
                                            } else if (buttonIndex >= controller.firstOtherButtonIndex) {
                                                
                                            }
                                        }];
}


- (IBAction)codeSendingAction:(UIButton *)sender {
    [self showAlertWithTitle:@"Lou" message:@"Này chưa có làm má ôi!"];
}

@end









