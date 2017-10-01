//
//  SignUpViewController.m
//  Tìm kiếm bệnh viện
//
//  Created by Kiet on 9/4/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SignUpViewController.h"


@interface SignUpViewController ()<UIImagePickerControllerDelegate>

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.segmentControl setSelectedSegmentIndex: 0];
    [self.segmentControl addTarget: self action:@selector(segmentAction:) forControlEvents: UIControlEventValueChanged];
    [self.findPhotoButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    if (self.segmentControl.selectedSegmentIndex == 0) {
        self.title = @"Đăng nhập";
    }else {
        self.title = @"Đăng kí";
    }
    [self showRightBarButtonItemWithTittle:@"Xong"];
    [self showLeftBarButtonItemWithTittle:@"Huỷ"];
}

- (IBAction)segmentAction:(id)sender {
    if (self.segmentControl.selectedSegmentIndex == 0) {
        [self.signInView setHidden:NO];
    }else {
        [self.signInView setHidden:YES];
    }
}

#pragma mark - CANCEL ACTION (Huỷ)

- (void)leftBarButtonAction:(id)sender { /// huỷ
    [self.view endEditing: true];
    
    BOOL isChecked = [self checkAllInputContent];
    if (isChecked == false) {
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
    } else {
        [self showAlertAndDismiss];
    }
}

- (void)showAlertAndDismiss {
    __weak SignUpViewController *wSelf = self;
    [UIAlertController showAlertInViewController:self
                                       withTitle:@"Xác nhận"
                                         message:@"bạn chắc chắn muốn huỷ bỏ?"
                               cancelButtonTitle:@"Không"
                          destructiveButtonTitle:@"Có"
                               otherButtonTitles:nil
                                        tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                            if (buttonIndex == controller.cancelButtonIndex) {
                                                
                                            } else if (buttonIndex == controller.destructiveButtonIndex) {
                                                [wSelf.navigationController dismissViewControllerAnimated:true completion:nil];
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

- (BOOL)checkAllInputContent {
    if (_userNameTextField.text.length == 0 && _passwordTextField.text.length == 0 && _emailTextField.text.length == 0 && _inputPasswordTextField.text.length == 0 && _fullNameTextField.text.length == 0 && _cityTextField.text.length == 0) {
        return false;
    }
    return true;
}

#pragma mark - DONE ACTION (Xong)

- (void)rightBarButtonAction:(id)sender {
    if (_segmentControl.selectedSegmentIndex == 0) {
        [self doneActionWhenIsInSignInView];
    } else {
        [self doneActionWhenIsInSignUpView];
    }
}

- (void)doneActionWhenIsInSignUpView {                                          /// Đăng kí
    __weak SignUpViewController *wSelf = self;
    [wSelf validateWithEmail:_emailTextField.text
                   password:_inputPasswordTextField.text
                   fullName:_fullNameTextField.text
                       city:_cityTextField.text
            completionBlock:^(NSString *message, BOOL isValidate) {
                if (isValidate == true) {
                    [wSelf showHUD];
                    [ApiRequest registerWithEmail: _emailTextField.text
                                         password: _inputPasswordTextField.text
                                             city: _cityTextField.text
                                         fullName: _fullNameTextField.text
                                       completion: ^(ApiResponse *response, NSError *error) {
                                           [wSelf hideHUD];
                                           if (response.success == 1) {
                                               [[UserDataManager sharedClient] setUserData:response.data];
                                               [wSelf showAlertNotificationAndLogin];
                                           } else {
                                               [wSelf showAlertWithTitle:@"Lỗi" message:response.message];
                                           }
                                       }];
                } else {
                    [wSelf showAlertWithTitle:@"Lỗi" message:message];
                }
            }];
}

- (void)showAlertNotificationAndLogin {
    [UIAlertController showAlertInViewController:self
                                       withTitle:@"Đăng kí thành công!"
                                         message:@""
                               cancelButtonTitle:@"Ok"
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil
                                        tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                            if (buttonIndex == controller.cancelButtonIndex) {
                                                AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                                [delegate setupHomeScreen2];
                                            }
                                        }];
}

- (void)doneActionWhenIsInSignInView {                                             /// Đăng nhập.
    __weak SignUpViewController *wSelf = self;

    [self validateWithEmail: _userNameTextField.text password:_passwordTextField.text completionBlock:^(NSString *message, BOOL isValidate) {
        if (isValidate == false) {
            [wSelf showAlertWithTitle:@"Lỗi" message: message];
        }
        else {
            [wSelf showHUD];
            [ApiRequest loginWithEmail:_userNameTextField.text
                              password:_passwordTextField.text
                            completion:^(ApiResponse *response, NSError *error) {
                                [wSelf hideHUD];
                                if (response.success == 0 || [response.data isKindOfClass: [NSNull class]]) {
                                    [wSelf showAlertWithTitle:@"Lỗi" message:@"Tên đăng nhập hoặc mật khẩu không đúng! \nXin mời nhập lại"];
                                }else {
                                        /// lưu vào UserDataManager.
                                    [[UserDataManager sharedClient] setUserData:response.data];
                                    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                    [delegate setupHomeScreen2];
                                }
                            }];
        }
    }];
}

#pragma mark - Another Buttons Action.

- (IBAction)forgotPasswordButtonAction:(id)sender {
    ForgotPasswordViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:view];
    [self presentViewController:nav animated:true completion:nil];
}

- (IBAction)selectCity:(UIButton *)sender {
    PlacesViewController *view = (PlacesViewController *)[PlacesViewController instanceFromStoryboardName:@"Login"];
    [view setBlock:^(NSString *city){
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

#pragma mark - Image Picker Delegate.

- (void)cancelButtonDidPress:(ImagePickerController *)imagePicker {
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)wrapperDidPress:(ImagePickerController *)imagePicker images:(NSArray<UIImage *> *)images {
    if (images.count <= 0) {
        return;
    }
}

- (void)doneButtonDidPress:(ImagePickerController *)imagePicker images:(NSArray<UIImage *> *)images {
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    _avatarImageView.image = [images firstObject];
}

- (void)buttonTouched:(UIButton *)button {
    ImagePickerController *imagePicker = [[ImagePickerController alloc] init];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}



@end













