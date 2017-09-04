//
//  LocationViewController.m
//  BenhVien-app
//
//  Created by test on 8/23/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D currentLocation;
}

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self getCurrentLocation];
}

- (void)setUpUserInterface {
    [self showBackButtonItem];
    if (self.currentHospital) {
        self.title = self.currentHospital.name;
    }
}

- (void)getCurrentLocation {
                                //// Codes make app be able to use google map.
                                //// then get the User current locations.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
                                                        // (NOTE) should learn by heart.
}


            	// OC Google Direction API.

- (void)showDirectionFromOriginLocation:(CLLocation *)originLocation andDestinateLocation:(CLLocation *)destinateLocation {
    
            //// Make a request with user location 
            //// and hospital location to the Server.
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation: originLocation
                                                           andDestinationLocation: destinateLocation];

    OCDirectionsAPIClient *client = [OCDirectionsAPIClient new];
    [client directions:request 
              response:^(OCDirectionsResponse *response, NSError *error) {
        
            //// Make the request running on main queue.
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                return;
            }
            if (response.status != OCDirectionsResponseStatusOK) {
                return;
            }
            
                //// Get the Routes to the Hospital.
            NSArray *routesArray = response.routes;
            GMSPolyline *polyline = nil;
            if (routesArray.count > 0) {
                OCDirectionsRoute *route = [response route];
                OCDirectionsPolyline *overViewPolyline = route.overviewPolyline;
                NSString *points = overViewPolyline.points;
                GMSPath *path = [GMSPath pathFromEncodedPath:points];
                polyline = [GMSPolyline polylineWithPath:path];
                polyline.strokeWidth = 3.5;
                polyline.geodesic = true;

                GMSStrokeStyle *grayYellow = [GMSStrokeStyle gradientFromColor:[UIColor darkGrayColor] toColor:[UIColor yellowColor]];
                polyline.spans = @[[GMSStyleSpan spanWithStyle:grayYellow]];
            }
            if (polyline) {
                GMSMarker *marker = [GMSMarker new];
                            //// Display the hospital location with a Marker.
                marker.position = CLLocationCoordinate2DMake(self.currentHospital.latitude, self.currentHospital.longitude);
                            //// Marker animation.
                [marker setAppearAnimation:kGMSMarkerAnimationPop];
                marker.map = _mapView;
                polyline.map = _mapView;
            }
        });
    }];
}


#pragma mark - CL Location Manager Delegate.

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    currentLocation = locations.lastObject.coordinate;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:currentLocation zoom: 15.0];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
    [locationManager stopUpdatingLocation];
    
        //// Get the hospital Location.
    CLLocation *hospialLocation = [[CLLocation alloc] initWithLatitude:_currentHospital.latitude
                                                             longitude:_currentHospital.longitude];
    
        //// Draw the Direction to the Hospital.
    [self showDirectionFromOriginLocation:[[CLLocation alloc] initWithLatitude:currentLocation.latitude
                                                                     longitude:currentLocation.longitude] andDestinateLocation:hospialLocation];
}

@end








