//
//  BaseTabbarController.m
//  BenhVien-app
//
//  Created by test on 7/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "BaseTabbarController.h"
#import "AppDelegate.h"

@interface BaseTabbarController ()

@property (nonatomic, strong) MenuView *menuView;
@property (strong, nonatomic) UIWindow *window;

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
    self.window = [[[UIApplication sharedApplication] delegate] window];
    [self.window addSubview: self.menuView];
    
    [self didSelectMenuAtRowIndexOfMenuTableView];
}

    /// Hàm override, hàm này mặc định dc gọi khi có sự kiện trên view xảy ra.
-(void)updateViewConstraints {

    [self.menuView autoPinEdge: ALEdgeTop toEdge: ALEdgeTop ofView: self.window];
    [self.menuView autoPinEdge: ALEdgeBottom toEdge: ALEdgeBottom ofView: self.window];
    [self.menuView autoPinEdge: ALEdgeLeft toEdge: ALEdgeLeft ofView: self.window];
    [self.menuView autoPinEdge: ALEdgeRight toEdge: ALEdgeRight ofView: self.window];

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

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BaseTabbarController *tab = (BaseTabbarController *)self.tabBarController;
    [self animatedMenu: tab.menuDisplayed];
}

- (void)didSelectMenuAtRowIndexOfMenuTableView {
        /// sao phải là weak?? Tại cái đéo nào mà phải là weak :v
    __weak BaseTabbarController *tab = self;
    
        /// cách implement một block
    [self.menuView setOneDidSelectItemAtIndexPath:^(NSInteger index) {

        /// truyền vào indexPath.row của menuTableView làm indexPath.item của tabbar.
        /// rồi đóng menu view.
        [tab animatedMenu: !tab.menuDisplayed];
        tab.selectedIndex = index;
    }];
}


@end

//    UIView *subView = self.view;
//    UIGraphicsBeginImageContextWithOptions(subView.bounds.size , NO, 0.0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [subView.layer renderInContext: context];
//    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageView *snapshotImageView = [[UIImageView alloc] initWithImage: snapshotImage];



