//
//  ForgotPasswordViewController.m
//  Tìm kiếm bệnh viện
//
//  Created by Kiet on 9/10/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UIAlertController+Blocks.h"
#import "ApiRequest.h"
#import "UserDataManager.h"

@interface ChangePasswordViewController ()
{
    BOOL _areFilled;
}

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Đổi mật khẩu";
    [self showLeftBarButtonItemWithTittle:@"Huỷ bỏ"];
    [self showRightBarButtonItemWithTittle:@"Xong"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)validateOldPassword:(NSString *)text1 newPassword:(NSString *)text2 confirmPassword:(NSString *)text3 completionBlock:(void (^)(NSString *message, BOOL isValidate))block {
    if (!text1 || text1.length == 0) {
        block(@"Bạn phải nhập mật khẩu cũ", false);
        return;
    }
    if (!text2 || text2.length == 0) {
        block(@"Bạn phải nhập mật khẩu mới", false);
        return;
    }
    if (!text3 || text3.length == 0) {
        block(@"Bạn chưa xác nhận mật khẩu", false);
        return;
    }
    block(@"", true);
    
}

- (void)rightBarButtonAction:(id)sender { /// Done button.
    
    NSString *userID = [UserDataManager sharedClient].userId;
    NSString *oldPassword = self.passwordTextField.text;
    NSString *newPassword = self.anotherPasswordTextField.text;
    NSString *confirmPassword = self.anotherPasswordTextField2.text;
    
    [self validateOldPassword:oldPassword
                  newPassword:newPassword
              confirmPassword:confirmPassword
              completionBlock:^(NSString *message, BOOL isValidate) {
                  if (isValidate) {
                      [self changePasswordWithUserId:userID oldPassword:oldPassword newPassword:newPassword];
                  } else {
                      [self showAlertWithTitle:@"Lỗi" message:message];
                  }
              }];
}

- (void)changePasswordWithUserId:(NSString *)userId oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword {
    [self showHUD];
    [ApiRequest changePasswordWithUserId:userId
                             oldPassword:oldPassword
                             newPassword:newPassword
                              completion:^(ApiResponse *response, NSError *error) {
                                  [self hideHUD];
                                  if (error) {
                                      [self showAlertWithTitle:@"Lỗi" message:error.description];
                                  } else {
                                      
                                  }
                              }];
}


- (void)leftBarButtonAction:(id)sender { /// Cancel button.
    if ([_passwordTextField.text isEqualToString:@""] &&
        [_anotherPasswordTextField.text isEqualToString:@""] &&
        [_anotherPasswordTextField2.text isEqualToString:@""]) {
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
    }else {
        [UIAlertController showAlertInViewController:self
                                           withTitle:@"Xác nhận"
                                             message:@"Bạn có chắc muốn huỷ bỏ?"
                                   cancelButtonTitle:@"Không"
                              destructiveButtonTitle:@"Có"
                                   otherButtonTitles:nil
                                            tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                if (buttonIndex == controller.destructiveButtonIndex) {
                                                    [self.navigationController dismissViewControllerAnimated:true completion:nil];
                                                } else if (buttonIndex == controller.cancelButtonIndex) {
                                                    
                                                }
                                            }];
    }
}

@end






















