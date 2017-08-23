//
//  UIColor+Hex.h
//  benhvien-app-objc
//
//  Created by HaoLe on 7/11/17.
//  Copyright © 2017 HaoLe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor*)colorWithCSS:(NSString*)css;
+ (UIColor*)colorWithHex:(NSUInteger)hex;

- (uint)hex;
- (NSString*)hexString;
- (NSString*)cssString;

@end
