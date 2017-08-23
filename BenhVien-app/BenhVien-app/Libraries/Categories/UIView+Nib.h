//
//  UIView+Nib.h
//  benhvien-app-objc
//
//  Created by HaoLe on 7/11/17.
//  Copyright © 2017 HaoLe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIView (Nib)

@property (nonatomic, assign) BOOL didSetupConstraints;

- (UIView *)viewFromNib;

@end
