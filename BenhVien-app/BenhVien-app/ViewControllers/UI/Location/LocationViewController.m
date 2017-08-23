//
//  LocationViewController.m
//  BenhVien-app
//
//  Created by test on 8/23/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()
{
    GMSPlacesClient *_placesClient;
}

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _placesClient = [GMSPlacesClient sharedClient];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
