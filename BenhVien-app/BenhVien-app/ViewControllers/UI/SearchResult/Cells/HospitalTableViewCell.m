//
//  HospitalTableViewCell.m
//  BenhVien-app
//
//  Created by test on 7/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "HospitalTableViewCell.h"

@implementation HospitalTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.hospitalImageView.layer.cornerRadius = 4.0;
    self.hospitalImageView.clipsToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setDataForCell:(id)data {

    Hospital *hospital = (Hospital *)data;
    if (hospital) {
        NSURL *URL = [NSURL URLWithString: hospital.avatar];
        [self.hospitalImageView sd_setImageWithURL:URL];
        self.HospitalPhone.text = [NSString stringWithFormat:@"Điện thoại: %@", hospital.phones[0]];
        self.HospitalName.text = hospital.name;
        self.HospitalAddress.text = [NSString stringWithFormat:@"Địa chỉ: %@", hospital.street];
    }else {
        self.HospitalPhone.text = @"_";
    }
}


@end
