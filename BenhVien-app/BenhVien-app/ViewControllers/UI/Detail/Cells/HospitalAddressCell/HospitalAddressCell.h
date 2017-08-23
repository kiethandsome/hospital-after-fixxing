//
//  AddressCell.h
//  BenhVien-app
//
//  Created by test on 7/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTableViewCell.h"
#import "HospitalAddressModel.h"

@interface HospitalAddressCell : HLTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *locationIcon;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
