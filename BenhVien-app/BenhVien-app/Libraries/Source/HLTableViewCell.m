//
//  HLTableViewCell.m
//  HLTableView
//
//  Created by HaoLe on 7/24/17.
//  Copyright © 2017 HaoLe. All rights reserved.
//

#import "HLTableViewCell.h"
#import "HLTableView.h"

@implementation HLTableViewCell

+ (NSString*)reuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (UINib*)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+ (CGFloat)height:(id)model {
    return UITableViewAutomaticDimension;
}

- (void)configureCell:(id)model {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (UITableView *)tableView {
    UIView *view = self.superview;
    while (view != nil && ![view isKindOfClass:[UITableView class]]) {
        view = view.superview;
    }
    
    if ([view isKindOfClass:[UITableView class]]) {
        return (UITableView*)view;
    }
    
    return nil;
}

- (NSIndexPath *)indexPath {
    return [[self tableView] indexPathForCell:self];
}

- (void)fireSignal:(NSString*)name associatedObject:(NSObject *)obj {
    HLTableView *tableView = (HLTableView *)[self tableView];
    if (tableView.onSignal) {
        tableView.onSignal(name, obj);
    }
}

@end
