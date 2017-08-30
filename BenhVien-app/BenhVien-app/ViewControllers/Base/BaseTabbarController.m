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
            //// Take the window from AppDelegate
            //// and add a Menu View under the Tabbar.
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview: _menuView];
}

- (void)animatedMenu:(BOOL)menuDisplayed {
    self.menuDisplayed = menuDisplayed;
    CGFloat duration = 0.3;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat posX = (300.0/375.0) *screenWidth;
    CGFloat conChimNon = screenWidth * 2/3;
    
            //// Set the First frame as a view frame.
    CGRect frame = self.view.frame;  //// Frame là 1 điểm nằm ở góc trên bên trái của view. Frame(x,y)
                                     //// x: khoảng cách từ Frame đến top view
                                     //// y: khoảng cách từ Frame đến rìa TRÁI view
    if (menuDisplayed) {
        //// Open Menu
        frame.origin.x = conChimNon;
    }else {
        //// Close Menu
        frame.origin.x = 0.0;
    }
    [UIView animateWithDuration:duration animations: ^{
        self.view.frame = frame;
    }];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}
@end








