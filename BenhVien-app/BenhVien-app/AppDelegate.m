//
//  AppDelegate.m
//  BenhVien-app
//
//  Created by test on 7/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+Hex.h"
#import "ApiEndpoint.h"
#import "UIViewController+Storyboard.h"
#import "UserDataManager.h"
#import "NSUserDefaults+Utility.h"
#import "Constant.h"

        // Views Importing.
#import "HomeViewController.h"
#import "BaseNavigationController.h"
#import "AppInfoViewController.h"
#import "BaseTabbarController.h"
#import "FirstLoginViewController.h"
#import "AccountViewController.h"

        // Google maps Importing.
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <OCGoogleDirectionsAPI/OCGoogleDirectionsAPI.h>
#import <HNKGooglePlacesAutocomplete/HNKGooglePlacesAutocomplete.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupApplicationTheme];
    [self setupGGPlaces];

    if ([UserDataManager sharedClient].accessToken && [UserDataManager sharedClient].accessToken.length >0) {      /// Nếu có accessToken tức là đã đăng nhập.
            /// Đi thẳng vào màn hình Home
        [self setupHomeScreen2];
    }else {
            /// Đi vào màn hình đăng nhập.
        [self setupHomeScreen3];
    }
    return YES;
}

- (void)setupGGPlaces {
    [GMSPlacesClient provideAPIKey:GoogleApiKey];
    [GMSServices provideAPIKey:GoogleApiKey];
    [OCDirectionsAPIClient provideAPIKey:GoogleApiKey];
    [HNKGooglePlacesAutocompleteQuery setupSharedQueryWithAPIKey:GoogleApiKey];
}

- (void)setupHomeScreen {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    HomeViewController *vc = (HomeViewController *)[HomeViewController instanceFromStoryboardName:@"Home"];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

- (void)setupHomeScreen2 {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    HomeViewController *homeVc = (HomeViewController *)[HomeViewController instanceFromStoryboardName:@"Home"];
    BaseNavigationController *HomeNav = [[BaseNavigationController alloc] initWithRootViewController:homeVc];
    
    AppInfoViewController *appInfoVC = (AppInfoViewController *)[AppInfoViewController instanceFromStoryboardName:@"Home"];
    BaseNavigationController *appInfoNav = [[BaseNavigationController alloc] initWithRootViewController:appInfoVC];
    
    AccountViewController *accVc = (AccountViewController *)[AccountViewController instanceFromStoryboardName:@"Home"];
    BaseNavigationController *accNav = [[BaseNavigationController alloc] initWithRootViewController:accVc];
    
    BaseTabbarController *tab = [BaseTabbarController new];
    tab.viewControllers = @[accNav, HomeNav, appInfoNav];
    tab.selectedIndex = 1;

    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
}

- (void)setupHomeScreen3 {
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    
    FirstLoginViewController *firstView = (FirstLoginViewController *)[FirstLoginViewController instanceFromStoryboardName: @"Login"];
    
    [self.window setRootViewController: firstView];
    [self.window makeKeyAndVisible];
}

- (void)setupApplicationTheme {
    
    [UINavigationBar appearance].barTintColor = [UIColor colorWithHex:0xd2232a];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    NSDictionary *tittleAtrr = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [UINavigationBar appearance].titleTextAttributes = tittleAtrr;
    
}


@end

















