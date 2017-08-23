//
//  HLTableViewSection.m
//  HLTableView
//
//  Created by HaoLe on 7/24/17.
//  Copyright © 2017 HaoLe. All rights reserved.
//

#import "HLTableViewSection.h"

@implementation HLTableViewSection

- (id)init {
    self = [super init];
    if (self) {
        _items = [NSMutableArray new];
    }
    return self;
}

- (void)setHeaderTitle:(NSString *)headerTitle {
    _headerTitle = headerTitle;
    // Set default header height in case title != nil and headerHeight is not set.
    if (_headerTitle != nil && [_headerTitle isEqualToString:@""] == false && _headerHeight == 0) {
        _headerHeight = DefaultHeaderHeight;
    }
}

- (void)setFooterTitle:(NSString *)footerTitle {
    _footerTitle = footerTitle;
    // Set default footer height in case title != nil and headerHeight is not set.
    if (_footerTitle != nil && [_footerTitle isEqualToString:@""] == false && _footerHeight == 0) {
        _footerHeight = DefaultFooterHeight;
    }
}

+ (instancetype)initWithItems:(NSArray*)items {
    HLTableViewSection *section = [HLTableViewSection new];
    section.items = [items mutableCopy];
    return section;
}


- (void)clear {
    [_items removeAllObjects];
}

@end
