//
//  MapCell.h
//  BenhVien-app
//
//  Created by Nguyen Anh Kiet on 8/1/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTableViewCell.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MapModel.h"

@interface MapCell : HLTableViewCell

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@end
