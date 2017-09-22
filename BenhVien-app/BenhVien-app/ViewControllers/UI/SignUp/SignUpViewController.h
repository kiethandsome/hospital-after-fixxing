//
//  SignUpViewController.h
//  Tìm kiếm bệnh viện
//
//  Created by Kiet on 9/4/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ApiRequest.h"
#import "ApiResponse.h"
#import "HomeViewController.h"
#import "BaseNavigationController.h"
#import "BaseTabbarController.h"
#import "AppInfoViewController.h"
#import "AppDelegate.h"
#import "ForgotPasswordViewController.h"
#import "PlacesViewController.h"
#import "AccountViewController.h"
#import "PlacesViewController.h"
#import "UserDataManager.h"
#import "UIAlertController+Blocks.h"
#import "ImagePickerController.h"

@interface SignUpViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIView *signUpView;
@property (weak, nonatomic) IBOutlet UIView *signInView;

/// SIgn in view
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

/// Sign up view
@property (weak, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *inputPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;

@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *findPhotoButton;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end
