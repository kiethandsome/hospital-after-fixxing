//
//  HLTableViewCell.h
//  HLTableView
//
//  Created by HaoLe on 7/24/17.
//  Copyright © 2017 HaoLe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLTableViewCell : UITableViewCell

+ (NSString*)reuseIdentifier;

+ (UINib*)nib;

+ (CGFloat)height:(id)model;

- (void)configureCell:(id)model;

- (UITableView*)tableView;

- (NSIndexPath*)indexPath;

- (void)fireSignal:(NSString*)name associatedObject:(NSObject*)obj;

@end
