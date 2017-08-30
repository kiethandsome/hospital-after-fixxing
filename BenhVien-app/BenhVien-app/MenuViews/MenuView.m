//
//  MenuView.m
//  BenhVien-app
//
//  Created by test on 8/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "MenuView.h"

@interface MenuView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MenuView

- (void)setupMenuView {
    _menuItems = [NSArray new];
    _menuItems = @[@"con chim non trên cành cây", @"Con chim già ĩa chảy"];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
        //// The most Important code line when using XIB file.
    _menuTableView.estimatedRowHeight = 60.0;
    [_menuTableView registerNib:[UINib nibWithNibName:@"MenuView" bundle:nil] forCellReuseIdentifier:@"MenuViewCell"];
}

#pragma mark Table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuViewCell *cell = (MenuViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuViewCell"];
    if (!cell) {
        cell = [[MenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuViewCell"];
    }
    switch (indexPath.row) {
        case 0:
            cell.cellImageView.image = [UIImage imageNamed:@"search-menu-icon.png"];
            break;
        case 1:
            cell.cellImageView.image = [UIImage imageNamed:@"information-menu-icon.png"];
            break;
        default:
            break;
    }
    cell.cellLabel.text = self.menuItems[indexPath.row];
    return cell;
}

#pragma mark table view data sources

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
