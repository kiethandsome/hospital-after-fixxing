//
//  HLTableViewSection.h
//  HLTableView
//
//  Created by HaoLe on 7/24/17.
//  Copyright © 2017 HaoLe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define DefaultHeaderHeight 22
#define DefaultFooterHeight 22

@interface HLTableViewSection : NSObject

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic) CGFloat footerHeight;
@property (nonatomic) CGFloat headerHeight;

+ (instancetype)initWithItems:(NSArray*)items;

- (void)clear;

@end
