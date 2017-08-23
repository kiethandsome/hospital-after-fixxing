//
//  UIView+Nib.m
//  benhvien-app-objc
//
//  Created by HaoLe on 7/11/17.
//  Copyright © 2017 HaoLe. All rights reserved.
//

#import "UIView+Nib.h"
#import <PureLayout/PureLayout.h>

NSString * const kSetupConstraintsKey = @"kSetupConstraintsKey";

@implementation UIView (Nib)

- (void)setDidSetupConstraints:(BOOL)didSetupConstraints {
    NSNumber *number = [NSNumber numberWithBool: didSetupConstraints];
    objc_setAssociatedObject(self, (__bridge const void *)(kSetupConstraintsKey), number , OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)didSetupConstraints {
    NSNumber *number = objc_getAssociatedObject(self, (__bridge const void *)(kSetupConstraintsKey));
    return [number boolValue];
}

- (UIView *)viewFromNib {
    Class class = [self class];
    NSString *nibName = NSStringFromClass(class);
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    UIView *view = [nibViews objectAtIndex:0];
    [self addSubview:view];
    [self seetupConstraintsForView:view];
    [self setNeedsUpdateConstraints]; // bootstrap Auto Layout
    return view;
}

- (void)seetupConstraintsForView:(UIView *)view {
    if (!self.didSetupConstraints) {
        [view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
        [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
        [view autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
        [view autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self];
        self.didSetupConstraints = YES;
    }
}


@end
