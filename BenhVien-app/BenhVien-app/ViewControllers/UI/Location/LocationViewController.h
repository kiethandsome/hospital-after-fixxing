//
//  LocationViewController.h
//  BenhVien-app
//
//  Created by test on 8/23/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "BaseViewController.h"
#import "ApiEndpoint.h"
#import "Hospital.h"

#import <GooglePlaces/GooglePlaces.h>
#import <GoogleMaps/GoogleMaps.h>
#import <OCGoogleDirectionsAPI/OCGoogleDirectionsAPI.h>

@interface LocationViewController : BaseViewController

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic) Hospital *currentHospital;

@end
