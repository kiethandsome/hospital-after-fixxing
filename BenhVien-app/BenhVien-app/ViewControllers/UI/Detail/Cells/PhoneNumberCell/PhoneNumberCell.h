//
//  PhoneCell.h
//  BenhVien-app
//
//  Created by Nguyen Anh Kiet on 8/1/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTableViewCell.h"
#import "PhoneNumberModel.h"

@interface PhoneNumberCell : HLTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *phoneIcon;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@end
