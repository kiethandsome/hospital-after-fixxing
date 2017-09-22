//
//  BaseTabbarController.h
//  BenhVien-app
//
//  Created by test on 7/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"
#import <PureLayout/PureLayout.h>
#import "AppDelegate.h"
#import "UserDataManager.h"
#import "UIAlertController+Blocks.h"

@interface BaseTabbarController : UITabBarController

@property (assign, nonatomic) BOOL menuDisplayed;

- (void)animatedMenu:(BOOL)menuDisplayed;

@end
