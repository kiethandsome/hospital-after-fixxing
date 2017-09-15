//
//  BaseViewController.m
//  BenhVien-app
//
//  Created by test on 7/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "BaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIAlertController+Blocks.h"
#import "BaseTabbarController.h"
#import "HomeViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)dealloc {
    NSLog( @"[%@] dealloc", [self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUserInterface];
    [self.tabBarController.tabBar setHidden: YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Show Navigation Bar Button Items

- (void)showMenuButtonItem {
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-menu"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonPressed:)];
    self.navigationItem.leftBarButtonItem = menuButton;
}

- (void)showBackButtonItem {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

//-------------------------------------

- (void)showLeftBarButtonItemWithTittle:(NSString *)tittle {
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize: 16]};
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:tittle
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(leftBarButtonAction:)];
    self.navigationItem.leftBarButtonItem = doneButton;
    [doneButton setTitleTextAttributes: attribute forState:UIControlStateNormal];
}

- (void)showRightBarButtonItemWithTittle:(NSString *)tittle {
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize: 16]};
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:tittle
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(rightBarButtonAction:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton setTitleTextAttributes: attribute forState:UIControlStateNormal];
}

- (IBAction)leftBarButtonAction:(id)sender{
    
}

- (IBAction)rightBarButtonAction:(id)sender{
    
}
//-------------------------------------

- (IBAction)menuButtonPressed:(id)sender{
    BaseTabbarController *tab = (BaseTabbarController *)self.tabBarController;
    [tab animatedMenu:!tab.menuDisplayed];
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

#pragma  mark - HUD show and hide

- (void)showHUD {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [MBProgressHUD showHUDAddedTo: self.view animated:true];
//    });
    [SVProgressHUD show];
}

- (void)hideHUD {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [MBProgressHUD hideHUDForView: self.view animated:false];
//    });
    [SVProgressHUD dismiss];
    
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    [UIAlertController showAlertInViewController:self
                                       withTitle:title
                                         message:message
                               cancelButtonTitle:@"OK"
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil
                                        tapBlock:nil];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel destructive:(NSString *)destruct{
    [UIAlertController showAlertInViewController:self
                                       withTitle:title
                                         message:message
                               cancelButtonTitle:cancel
                          destructiveButtonTitle:destruct
                               otherButtonTitles:nil
                                        tapBlock:nil];
}


@end





































