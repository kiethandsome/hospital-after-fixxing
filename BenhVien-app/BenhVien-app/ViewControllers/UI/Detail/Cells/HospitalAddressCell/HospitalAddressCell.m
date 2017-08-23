//
//  AddressCell.m
//  BenhVien-app
//
//  Created by test on 7/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "HospitalAddressCell.h"

@implementation HospitalAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configureCell:(id)model {
    HospitalAddressModel *addressModel = (HospitalAddressModel *)model;
    if (addressModel) {
        self.addressLabel.text = addressModel.address;
    }
}


@end








