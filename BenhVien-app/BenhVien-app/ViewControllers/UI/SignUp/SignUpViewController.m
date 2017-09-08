//
//  SignUpViewController.m
//  Tìm kiếm bệnh viện
//
//  Created by Kiet on 9/4/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SignUpViewController.h"
#import "ApiRequest.h"
#import "ApiResponse.h"
#import "HomeViewController.h"
#import "BaseNavigationController.h"
#import "BaseTabbarController.h"
#import "AppInfoViewController.h"
#import "AppDelegate.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.segmentControl addTarget: self action:@selector(segmentAction:) forControlEvents: UIControlEventValueChanged];
    [self.segmentControl setSelectedSegmentIndex: 0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.segmentControl.selectedSegmentIndex == 0) {
        self.title = @"Đăng nhập";
    }else {
        self.title = @"Đăng kí";
    }
            /// set attribute for the Bar button.
    NSDictionary *attribute = @{ NSFontAttributeName : [UIFont systemFontOfSize: 16]};
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Huỷ bỏ"
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(cancelButtonAction)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Xong"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(doneActionButton)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    self.navigationItem.leftBarButtonItem = doneButton;
    
    [cancelButton setTitleTextAttributes: attribute forState:UIControlStateNormal];
    [doneButton setTitleTextAttributes: attribute forState:UIControlStateNormal];
}

- (void)cancelButtonAction {
                                /// Nút huỷ bỏ trước khi thực thi thường Confirm lại hành động của người dùng.
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Xác nhận" message:@"Mày chắc chưa?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OKaction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated: true completion: nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Huỷ" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:OKaction];
    [alert addAction:cancelAction];
    [self presentViewController: alert animated: true completion:nil];
}


- (void)doneActionButton {
    if (_segmentControl.selectedSegmentIndex == 0) {
        [self doneActionWhenIsInSignInView];
    } else {
        [self doneActionWhenIsInSignUpView];
    }
}

    // Kiểm tra Email và mật khẩu.
- (void) validateWithEmail:(NSString *)email password:(NSString *)password completionBlock:(void (^)(NSString *message, BOOL isValidate))block {
    if (!email || email.length == 0) {
        block(@"Bạn phải nhập Email", false);
        return;
    }
    if (!password || password.length == 0) {
        block(@"Bạn phải nhập mật khẩu", false);
        return;
    }
    return;
}

- (void)doneActionWhenIsInSignUpView {
    if ([_emailTextField.text isEqualToString:@""] ||
        [_inputPasswordTextField.text isEqualToString:@""] ||
        [_cityTextField.text isEqualToString:@""] ||
        [_fullNameTextField.text isEqualToString:@""])
    {
        [self showAlertWithTitle:@"Lỗi" message:@"Bạn phải điền đầy đủ thông tin!"];
    }
    else
    {
        [self showHUD];
        [ApiRequest registerWithEmail: _emailTextField.text
                             password: _inputPasswordTextField.text
                                 city: _cityTextField.text
                             fullName: _fullNameTextField.text
                           completion: ^(ApiResponse *response, NSError *error) {
                               [self hideHUD];
                               if (response.data) {
                                   [self showAlertWithTitle:@"Đăng kí thành công!" message:@"Hãy đăng nhập"];
                                   AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                   [delegate setupHomeScreen2];
                                        /// lưu token vào UserDefaults.
                                   NSString *token = [response.data objectForKey:@"token"];
                                   [[NSUserDefaults standardUserDefaults] setObject: token forKey:@"isLogin"];
                                   [[NSUserDefaults standardUserDefaults] synchronize];
                               }
                           }];
    }
}

- (void)doneActionWhenIsInSignInView {
//    [self validateWithEmail: _userNameTextField.text password:_passwordTextField.text completionBlock:^(NSString *message, BOOL isValidate) {
//        if (isValidate == false) {
//            [self showAlertWithTitle:@"Lỗi" message: message];
//        }
//        else {
//            [self showHUD];
//            [ApiRequest loginWithEmail:_userNameTextField.text
//                              password:_passwordTextField.text
//                            completion:^(ApiResponse *response, NSError *error) {
//                                if (!response.data) {
//                                    [self showAlertWithTitle:@"Lỗi" message:@"Tên đăng nhập hoặc mật khẩu không đúng!"];
//                                }else {
//                                    [self hideHUD];
//                                    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//                                    [delegate setupHomeScreen2];
//                                        /// lưu token vào UserDefaults.
//                                    NSString *token = [response.data objectForKey:@"token"];
//                                    [[NSUserDefaults standardUserDefaults] setObject: token forKey:@"isLogin"];
//                                    [[NSUserDefaults standardUserDefaults] synchronize];
//                                }
//                            }];
//        }
//    }];
    
    if ([self.userNameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""]) {
        [self showAlertWithTitle:@"Lỗi" message:@"Kiệt đẹp trai thế ko biết ^^"];
    } else {
        [self showHUD];
        [ApiRequest loginWithEmail:_userNameTextField.text
                          password:_passwordTextField.text
                            completion:^(ApiResponse *response, NSError *error) {
                                if (!response.data ||  error) {
                                    [self showAlertWithTitle:@"Lỗi" message:[error localizedDescription]];
                                }else {
                                    [self hideHUD];
                                    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                    [delegate setupHomeScreen2];
                                        /// lưu token vào UserDefaults.
                                    NSString *token = [response.data objectForKey:@"token"];
                                    [[NSUserDefaults standardUserDefaults] setObject: token forKey:@"isLogin"];
                                    [[NSUserDefaults standardUserDefaults] synchronize];
                                }
                            }];
    }
}

- (IBAction)segmentAction:(id)sender {
    if (self.segmentControl.selectedSegmentIndex == 0) {
        [self.signInView setHidden: NO];
    }else {
        [self.signInView setHidden: YES];
    }
}

- (IBAction)forgotPasswordButtonAction:(id)sender {


}

@end













