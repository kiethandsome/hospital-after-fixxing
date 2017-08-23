//
//  UITextField+Padding.m
//  benhvien-app-objc
//
//  Created by HaoLe on 7/12/17.
//  Copyright © 2017 HaoLe. All rights reserved.
//

#import "UITextField+Padding.h"

@implementation UITextField (Padding)

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 10, bounds.origin.y + 8,
                      bounds.size.width - 20, bounds.size.height - 16);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
