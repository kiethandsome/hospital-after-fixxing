//
//  InfCell.h
//  BenhVien-app
//
//  Created by Nguyen Anh Kiet on 8/1/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTableViewCell.h"
#import "HospitalDescriptionModel.h"

@interface HospitalDescriptionCell : HLTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *hospitalInformationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *informationIcon;

@end
