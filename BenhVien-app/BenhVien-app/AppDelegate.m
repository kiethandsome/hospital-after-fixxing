//
//  AppDelegate.m
//  BenhVien-app
//
//  Created by test on 7/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "UIViewController+Storyboard.h"
#import "BaseNavigationController.h"
#import "UIColor+Hex.h"
#import "ApiEndpoint.h"
#import "AppInfoViewController.h"
#import "BaseTabbarController.h"

        // Google maps Importing.
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <OCGoogleDirectionsAPI/OCGoogleDirectionsAPI.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupHomeScreen2];
    [self setupApplicationTheme];
            // Google map places.
    [GMSPlacesClient provideAPIKey:GoogleApiKey];
            // Google maps view.
    [GMSServices provideAPIKey:GoogleApiKey];
            // OC Google Direction API.
    [OCDirectionsAPIClient provideAPIKey:GoogleApiKey];

    return YES;
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
    
    BaseTabbarController *tab = [BaseTabbarController new];
    tab.viewControllers = @[HomeNav, appInfoNav];
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
}

- (void)setupApplicationTheme {
    
    [UINavigationBar appearance].barTintColor = [UIColor colorWithHex:0xd2232a];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    NSDictionary *tittleAtrr = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [UINavigationBar appearance].titleTextAttributes = tittleAtrr;
    
}


@end

















