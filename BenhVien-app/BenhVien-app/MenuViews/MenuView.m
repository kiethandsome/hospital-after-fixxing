//
//  MenuView.m
//  BenhVien-app
//
//  Created by test on 8/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "MenuView.h"
#import "AppDelegate.h"
#import "UserDataManager.h"

@interface MenuView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MenuView

- (void)setupMenuView {
    _menuItems = [NSArray new];
    _menuItems = @[@{@"tittle":@"Tìm kiếm", @"icon": @"search-menu-icon.png"},
                   @{@"tittle":@"Thông tin", @"icon": @"information-menu-icon.png"},
                   @{@"tittle":@"Đăng xuất", @"icon":@"logout-icon.png"}];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    [_menuTableView setScrollEnabled:false];
    [self.menuTableView setTableFooterView: [UIView new]];
        //// The most Important code line when using XIB file.
    _menuTableView.estimatedRowHeight = 60.0;
    [_menuTableView registerNib:[UINib nibWithNibName:@"MenuViewCell" bundle:nil] forCellReuseIdentifier:@"MenuViewCell"];
    _menuTableView.userInteractionEnabled = YES;
    
    self.userImageView.layer.cornerRadius = 18.0;
    self.userImageView.clipsToBounds = YES;
}

#pragma mark Table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuViewCell *cell = (MenuViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuViewCell"];
    if (!cell) {
        cell = [[MenuViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"MenuViewCell"];
    }
    cell.cellImageView.image = [UIImage imageNamed:[self.menuItems[indexPath.row] objectForKey:@"icon"]];
    cell.cellLabel.text = [self.menuItems[indexPath.row] objectForKey:@"tittle"];
        /// set selected Cell color.
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor redColor];
    [cell setSelectedBackgroundView:bgColorView];
    return cell;
}

#pragma mark table view data sources

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.row == 2) {
            /// Đăng xuất về màn hình đăng nhập.
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [delegate setupHomeScreen3];
            /// Huỷ token trong userDefaults.
        [[UserDataManager sharedClient] clearUserData];
    }
    self.oneDidSelectItemAtIndexPath(indexPath.row);
}

- (IBAction)moveToUserInfoScreen:(UIButton *)sender {
    self.oneDidSelectItemAtIndexPath(2);
    /// truyền vào tham số 3 để đi đến Account vc.
}

@end


























