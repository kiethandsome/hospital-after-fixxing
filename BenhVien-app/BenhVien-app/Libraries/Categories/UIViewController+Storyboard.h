//
//  UIViewController+Storyboard.h
//  benhvien-app-objc
//
//  Created by HaoLe on 7/11/17.
//  Copyright © 2017 HaoLe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Storyboard)

+ (UIViewController *)instanceFromNibWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle;

+ (UIViewController *)instanceFromStoryboardName:(NSString *)storyboardName;

- (void)setUpComponentsOnLoad;

- (void)setUpComponentsOnWillAppear;

- (void)setUpComponentsOnDidAppear;

- (void)setUpComponentsOnWillDisappear;

- (void)setUpComponentsOnDidDisappear;

- (void)setUpNavigationBar;

- (void)setUpUserInterface;

- (void)configUserInterface;

@end
