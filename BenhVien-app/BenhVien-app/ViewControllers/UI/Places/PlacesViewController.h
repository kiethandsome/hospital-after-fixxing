//
//  PlacesViewController.h
//  BenhVien-app
//
//  Created by Kiet on 9/11/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "BaseViewController.h"
#import "CitiesTableViewCell.h"
#import "UIAlertController+Blocks.h"
#import <HNKGooglePlacesAutocomplete/HNKGooglePlacesAutocomplete.h>
#import "SignUpViewController.h"

@interface PlacesViewController : BaseViewController

@property (nonatomic) IBOutlet UITableView *cityTableView;

@property (nonatomic) void (^block)(NSString *text, UIViewController *vc);

@end
