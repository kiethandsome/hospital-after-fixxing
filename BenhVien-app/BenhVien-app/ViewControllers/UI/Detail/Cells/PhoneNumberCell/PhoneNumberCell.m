//
//  PhoneCell.m
//  BenhVien-app
//
//  Created by Nguyen Anh Kiet on 8/1/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "PhoneNumberCell.h"

@implementation PhoneNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configureCell:(id)model {
    PhoneNumberModel *phoneModel = (PhoneNumberModel *)model;
    if (phoneModel) {
        self.phoneNumberLabel.text = phoneModel.phoneNumbers[0];
    }
}

@end
