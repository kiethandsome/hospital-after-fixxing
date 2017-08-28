//
//  MenuView.h
//  BenhVien-app
//
//  Created by test on 8/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewCell.h"

@interface MenuView : UIView

@property (nonatomic) NSArray *menuItems;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

- (void)setupMenuView;

@end
