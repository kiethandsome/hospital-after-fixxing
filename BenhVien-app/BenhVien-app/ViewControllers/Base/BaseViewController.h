//
//  BaseViewController.h
//  BenhVien-app
//
//  Created by test on 7/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Storyboard.h"

@interface BaseViewController : UIViewController

// Tạo 2 phương thức hiển thị nút MEnu và nút Back cho các màn hình.
- (void)showMenuButtonItem;
- (void)showBackButtonItem;

// HUD.
- (void)showHUD;
- (void)hideHUD;

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;
@end
