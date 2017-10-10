//
//  BaseTabbarController.m
//  BenhVien-app
//
//  Created by test on 7/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "BaseTabbarController.h"


@interface BaseTabbarController ()

@property (nonatomic, strong) MenuView *menuView;
@property (nonatomic) BOOL didUpdateConstraint;

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMenuView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupMenuView {
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"MenuView" owner:self options:nil];
    self.menuView = (MenuView *)[nibViews objectAtIndex: 0];
    [self.menuView setupMenuView];
            //// Take the window from AppDelegate
            //// and add a Menu View under the Tabbar.
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview: self.menuView];
    
    [self didSelectMenuAtRowIndexOfMenuTableView];
}

/// Hàm override, hàm này mặc định dc gọi khi có sự kiện trên view xảy ra.
-(void)updateViewConstraints {
    if (!_didUpdateConstraint) {
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [self.menuView autoPinEdge: ALEdgeTop toEdge: ALEdgeTop ofView: window];
        [self.menuView autoPinEdge: ALEdgeBottom toEdge: ALEdgeBottom ofView: window];
        [self.menuView autoPinEdge: ALEdgeLeft toEdge: ALEdgeLeft ofView: window];
        [self.menuView autoPinEdge: ALEdgeRight toEdge: ALEdgeRight ofView: window];
        self.didUpdateConstraint = true;
    }
    [super updateViewConstraints];
}

- (void)animatedMenu:(BOOL)menuDisplayed {
    self.menuDisplayed = menuDisplayed;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = self.view.frame;
    
    if (menuDisplayed) {
        /// Open Menu
        frame.origin.x = screenWidth * 0.8;
    }else {
        /// Close Menu
        frame.origin.x = 0.0;
    }
    [UIView animateWithDuration: 0.3 animations: ^{
        self.view.frame = frame;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    BaseTabbarController *tab = (BaseTabbarController *)self.tabBarController;
    [self animatedMenu: tab.menuDisplayed];
    [self.view endEditing:true];
}

- (void)didSelectMenuAtRowIndexOfMenuTableView {
    [self.view endEditing:true];
    
    __weak BaseTabbarController *tab = self;
        /* cách implement một block */
    [tab.menuView setOneDidSelectItemAtIndexPath:^(NSInteger index) {
        [tab animatedMenu: !tab.menuDisplayed];
        if (index == 3) {
            [UIAlertController showAlertInViewController:tab
                                               withTitle:@"Xác nhận"
                                                 message:@"Bạn có chắc muốn đăng xuất?"
                                       cancelButtonTitle:@"Không"
                                  destructiveButtonTitle:@"Có"
                                       otherButtonTitles:nil
                                                tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                    if (buttonIndex == controller.cancelButtonIndex) {
                                                        
                                                    } else if(buttonIndex == controller.destructiveButtonIndex) {
                                                        [tab logOut];
                                                    }
                                                }];
        }
        tab.selectedIndex = index;
    }];
}

- (void)logOut {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate setupHomeScreen3];
    [[UserDataManager sharedClient] clearUserData];
}

@end

//    UIView *subView = self.view;
//    UIGraphicsBeginImageContextWithOptions(subView.bounds.size , NO, 0.0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [subView.layer renderInContext: context];
//    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageView *snapshotImageView = [[UIImageView alloc] initWithImage: snapshotImage];








