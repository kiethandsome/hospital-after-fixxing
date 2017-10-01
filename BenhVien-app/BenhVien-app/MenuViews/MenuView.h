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
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (nonatomic) void (^oneDidSelectItemAtIndexPath)(NSInteger index);
@property (weak, nonatomic) IBOutlet UIView *userView;

- (void)setupMenuView;

@end


//// Cách làm : tạo một biến Block truyền vào tham số kiêu NSIteger tronng MenuTableView.
//// implement biến block trên trong hàm Cell For Row của MEnuTableVIew delegate.
//// ở file BAse Tabbar gọi biến Block đó và truyền vào [selected Index của tabbar] vào biến block vùa tạo
