//
//  DetailsViewController.h
//  BenhVien-app
//
//  Created by test on 7/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ApiRequest.h"
#import "Hospital.h"

    // cells impporting.
#import "SlideShowCell.h"
#import "HospitalNameCell.h"
#import "HospitalAddressCell.h"
#import "HospitalDescriptionCell.h"
#import "PhoneNumberCell.h"
#import "MapCell.h"
#import "HLTableView.h"

    // Models Importing.
#import "SlideShowModel.h"
#import "HospitalNameModel.h"
#import "HospitalAddressModel.h"
#import "PhoneNumberModel.h"
#import "MapModel.h"
#import "HospitalDescriptionModel.h"

    // googe maps and places importing.
#import <GooglePlaces/GooglePlaces.h>
#import <GoogleMaps/GoogleMaps.h>

@interface DetailsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet HLTableView *searchResultTableView;
@property (nonatomic, strong) Hospital *currentHospital;

    // Places Client Object.
@property (nonatomic) GMSPlacesClient *_placesClient;

@end
