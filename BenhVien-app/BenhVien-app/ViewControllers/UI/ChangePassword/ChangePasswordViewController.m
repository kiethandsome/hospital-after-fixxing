//
//  ForgotPasswordViewController.m
//  Tìm kiếm bệnh viện
//
//  Created by Kiet on 9/10/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UIAlertController+Blocks.h"

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

//- (void)allOfTheTextFieldsAreFilled:(NSString *)firstTextField
//                  secondOne:(NSString *)secondTextField
//                   thirdOne:(NSString *)thirdTextField {
//    if ([firstTextField isEqualToString:@""] ||
//        [secondTextField isEqualToString:@""] ||
//        [thirdTextField isEqualToString:@""]) {
//        _areFilled = false;
//    }
//    _areFilled = true;
//}

- (void)rightBarButtonAction:(id)sender {
}

- (void)leftBarButtonAction:(id)sender { /// Cancel button.
//    [self allOfTheTextFieldsAreFilled:_passwordTextField.text
//                            secondOne:_anotherPasswordTextField.text
//                             thirdOne:_anotherPasswordTextField2.text];
    
    if ([_passwordTextField.text isEqualToString:@""] &&
        [_anotherPasswordTextField.text isEqualToString:@""] &&
        [_anotherPasswordTextField2.text isEqualToString:@""]) {
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
    }else {
        [UIAlertController showAlertInViewController:self
                                           withTitle:@"Xác nhận"
                                             message:@"Bạn có chắc muốn huỷ bỏ?"
                                   cancelButtonTitle:@"Không"
                              destructiveButtonTitle:@"Huỷ"
                                   otherButtonTitles:nil
                                            tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                if (buttonIndex == 1) {
                                                    [self.navigationController dismissViewControllerAnimated:true completion:nil];
                                                }
                                                
                                            }];
    }

}

@end






























