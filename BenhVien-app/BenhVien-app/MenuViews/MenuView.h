//
//  MenuView.h
//  BenhVien-app
//
//  Created by test on 8/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewCell.h"
#import "HomeViewController.h"
#import "AppInfoViewController.h"

@interface MenuView : UIView

@property (nonatomic) NSArray *menuItems;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (nonatomic) void (^oneDidSelectItemAtIndexPath)(NSInteger index);

- (void)setupMenuView;

@end
