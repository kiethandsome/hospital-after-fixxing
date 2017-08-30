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
@property (strong, nonatomic) UIWindow *window;

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMenuView];
    [self.tabBar setHidden: true];
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
    [self.window addSubview: _menuView];
    
    __weak BaseTabbarController *tab = self;
    [self.menuView setOneDidSelectItemAtIndexPath:^(NSInteger index) {
        [tab didSelectMenuAtIndex: index];
    }];
}

-(void)updateViewConstraints {
    [self.menuView autoPinEdge: ALEdgeTop
                        toEdge: ALEdgeTop
                        ofView: self.window]; //// top của menu sẽ dính với top của window.
                                              //// (công dụng của PureLayout).
    [self.menuView autoPinEdge: ALEdgeBottom toEdge: ALEdgeBottom ofView: self.window];
    [self.menuView autoPinEdge: ALEdgeLeft toEdge: ALEdgeLeft ofView: self.window];
    [self.menuView autoPinEdge: ALEdgeRight toEdge: ALEdgeRight ofView: self.window];

    [super updateViewConstraints];
}

- (void)animatedMenu:(BOOL)menuDisplayed {
    self.menuDisplayed = menuDisplayed;
    CGFloat duration = 0.3;
    
        //// Set custom screen width and heigth.
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
            //// Set the First frame as a view frame.
    CGRect frame = self.view.frame;  //// Frame là 1 điểm nằm ở góc trên bên trái của view. Frame(x,y)
                                     //// x: khoảng cách từ Frame đến top view (origin x)
                                     //// y: khoảng cách từ Frame đến rìa TRÁI view (origin y)
    if (menuDisplayed) {
        //// Open Menu
//        frame.origin.x = posX;
        frame.origin.y = screenHeight * 0.5;
    }else {
        //// Close Menu
        frame.origin.x = 0.0;
        frame.origin.y = 0.0;
    }
    [UIView animateWithDuration:duration animations: ^{
        self.view.frame = frame;
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BaseTabbarController *tab = (BaseTabbarController *)self.tabBarController;
    [self animatedMenu: tab.menuDisplayed];
}

- (void)didSelectMenuAtIndex:(NSInteger)index {
    [self animatedMenu:!self.menuDisplayed];
    self.selectedIndex = index;
}


@end


//
//UIView *subView = self.viewWithManySubViews;
//UIGraphicsBeginImageContextWithOptions(subView.bounds.size, YES, 0.0f);
//CGContextRef context = UIGraphicsGetCurrentContext();
//[subView.layer renderInContext:context];
//UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
//UIGraphicsEndImageContext();
//
//UIImageView *snapshotImageView = [[UIImageView alloc] initWithImage:snapshotImage];



