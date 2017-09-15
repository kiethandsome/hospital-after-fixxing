//
//  SignUpViewController.m
//  Tìm kiếm bệnh viện
//
//  Created by Kiet on 9/4/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SignUpViewController.h"
#import "AccountViewController.h"
#import "PlacesViewController.h"
#import "UserDataManager.h"
#import "UserDataManager.h"

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
    [self showRightBarButtonItemWithTittle:@"Huỷ"];
    [self showLeftBarButtonItemWithTittle:@"Xong"];
}

- (IBAction)segmentAction:(id)sender {
    if (self.segmentControl.selectedSegmentIndex == 0) {
        [self.signInView setHidden:NO];
    }else {
        [self.signInView setHidden:YES];
    }
}

#pragma mark - CANCEL ACTION (Huỷ)

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



#pragma mark - Validate Email & Password

- (void)validateWithEmail:(NSString *)email password:(NSString *)password completionBlock:(void (^)(NSString *message, BOOL isValidate))block {
    if (!email || email.length == 0) {
        block(@"Bạn phải nhập Email", false);
        return;
    }
    if (!password || password.length == 0) {
        block(@"Bạn phải nhập mật khẩu", false);
        return;
    }
    block(@"", true);
}

- (void)validateWithEmail:(NSString *)email password:(NSString *)password fullName:(NSString *)fullName city:(NSString *)city completionBlock:(void (^)(NSString *message, BOOL isValidate))block {
    if (!fullName || fullName.length == 0) {
        block(@"Bạn phải nhập họ tên", false);
        return;
    }
    if (!email || email.length == 0) {
        block(@"Bạn phải nhập Email", false);
        return;
    }
    if (!password || password.length == 0) {
        block(@"Bạn phải nhập mật khẩu", false);
        return;
    }
    if (!city || city.length == 0) {
        block(@"Bạn phải nhập thành phố", false);
        return;
    }
    
    block(@"", true);
}

#pragma mark - DONE ACTION (Xong)

- (void)leftBarButtonAction:(id)sender {
    if (_segmentControl.selectedSegmentIndex == 0) {
        [self doneActionWhenIsInSignInView];
    } else {
        [self doneActionWhenIsInSignUpView];
    }
}

- (void)doneActionWhenIsInSignUpView {                                          /// Đăng kí
    [self validateWithEmail:_emailTextField.text
                   password:_inputPasswordTextField.text
                   fullName:_fullNameTextField.text
                       city:_cityTextField.text
            completionBlock:^(NSString *message, BOOL isValidate) {
                if (isValidate == true) {
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
                                               
                                               /// lưu vào UserDataManager.
                                               [[UserDataManager sharedClient] setUserData:response.data];
                                           }
                                       }];
                }
                else {
                    [self showAlertWithTitle:@"Lỗi" message:message];
                }
            }];
}

- (void)doneActionWhenIsInSignInView {                                             /// Đăng nhập.
    [self validateWithEmail: _userNameTextField.text password:_passwordTextField.text completionBlock:^(NSString *message, BOOL isValidate) {
        if (isValidate == false) {
            [self showAlertWithTitle:@"Lỗi" message: message];
        }
        else {
            [self showHUD];
            [ApiRequest loginWithEmail:_userNameTextField.text
                              password:_passwordTextField.text
                            completion:^(ApiResponse *response, NSError *error) {
                                if (response.success == 0 || [response.data isKindOfClass: [NSNull class]]) {
                                    [self hideHUD];
                                    [self showAlertWithTitle:@"Lỗi" message:@"Tên đăng nhập hoặc mật khẩu không đúng! \nXin mời nhập lại"];
                                }else {
                                    [self hideHUD];
                                    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                    [delegate setupHomeScreen2];
                                    
                                        /// lưu vào UserDataManager.
                                    [[UserDataManager sharedClient] setUserData:response.data];
                                }
                            }];
        }
    }];
}

- (IBAction)forgotPasswordButtonAction:(id)sender {
    ForgotPasswordViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:view];
    [self presentViewController:nav animated:true completion:nil];
}

- (IBAction)selectCity:(UIButton *)sender {
    PlacesViewController *view = (PlacesViewController *)[PlacesViewController instanceFromStoryboardName:@"Login"];
    [view setBlock:^(NSString *city, UIViewController *vc){
        NSLog(@"%@", city);
        self.cityTextField.text = city;
    }];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:view];
    [self presentViewController:nav animated:true completion:nil];
}

- (IBAction)takePhotoButtonAction:(UIButton *)sender {
    NSString *stringURL = @"youtube://watch?v=qDFzlwdAqtg";
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)findPhotoButtonAction:(UIButton *)sender {
    
}


@end













