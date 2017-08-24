//
//  MapCell.m
//  BenhVien-app
//
//  Created by Nguyen Anh Kiet on 8/1/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "MapCell.h"

@implementation MapCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(id)model {
    MapModel *mapModel = (MapModel *)model;
    if (mapModel) {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate at zoom level 15.
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: mapModel.latitude
                                                                longitude: mapModel.longatitude
                                                                     zoom:15];
        self.mapView.camera = camera;
        self.mapView.myLocationEnabled = YES;
        
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(mapModel.latitude, mapModel.longatitude);
        marker.map = self.mapView;
    }
}

@end
