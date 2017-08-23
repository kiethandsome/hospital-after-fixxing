//
//  UIViewController+Storyboard.m
//  benhvien-app-objc
//
//  Created by HaoLe on 7/11/17.
//  Copyright © 2017 HaoLe. All rights reserved.
//

#import "UIViewController+Storyboard.h"

@implementation UIViewController (Storyboard)

+ (UIViewController *)instanceFromNibWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    NSString* _nibName = nil;
    if (!nibName || [nibName isKindOfClass:[NSNull class]]) {
        NSString* fullClassName = NSStringFromClass(self);
        NSString* className = [fullClassName componentsSeparatedByString:@"."].lastObject;
        if (className) {
            _nibName = className;
        }else {
            _nibName = nibName;
        }
    }
    return [[UIViewController alloc] initWithNibName:_nibName bundle:bundle];
}

+ (UIViewController *)instanceFromStoryboardName:(NSString *)storyboardName {
    NSString* fullClassName = NSStringFromClass(self);
    NSString* storyboardId = [fullClassName componentsSeparatedByString:@"."].lastObject;
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:storyboardId];
    return vc;
}

- (void)setUpComponentsOnLoad {
}

- (void)setUpComponentsOnWillAppear {
}

- (void)setUpComponentsOnDidAppear {
}

- (void)setUpComponentsOnWillDisappear {
}

- (void)setUpComponentsOnDidDisappear {
}

- (void)setUpNavigationBar {
}

- (void)setUpUserInterface {
}

- (void)configUserInterface {
}

@end
