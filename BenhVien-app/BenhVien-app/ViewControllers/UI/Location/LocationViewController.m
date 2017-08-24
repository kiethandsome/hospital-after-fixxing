//
//  LocationViewController.m
//  BenhVien-app
//
//  Created by test on 8/23/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // OCGoogleDirectionAPI
    [OCDirectionsAPIClient provideAPIKey:GoogleApiKey];  
    [self viewUserLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
        
        // OCGoogleDirectionAPI
- (void)viewUserLocation {
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:@"<ORIGIN>" andDestinationString:@"<DESTINATION>"];
    
    OCDirectionsAPIClient *client = [OCDirectionsAPIClient new];
    [client directions:request response:^(OCDirectionsResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // e.g.
            if (error) {
                return;
            }
            if (response.status != OCDirectionsResponseStatusOK) {
                // Create a GMSCameraPosition that tells the map to display the
                // coordinate at zoom level 20.
                GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.currentHospital.latitude
                                                                        longitude:self.currentHospital.longitude
                                                                             zoom:20];
                self.mapView.camera = camera;
                self.mapView.myLocationEnabled = YES;
                
                // Creates a marker in the center of the map.
                GMSMarker *marker = [[GMSMarker alloc] init];
                marker.position = CLLocationCoordinate2DMake(self.currentHospital.latitude,self.currentHospital.longitude);
                marker.map = self.mapView;
            }

        });
        
    }];
}



@end
