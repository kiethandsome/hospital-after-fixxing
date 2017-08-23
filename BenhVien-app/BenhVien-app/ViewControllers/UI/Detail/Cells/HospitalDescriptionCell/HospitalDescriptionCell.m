//
//  InfCell.m
//  BenhVien-app
//
//  Created by Nguyen Anh Kiet on 8/1/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "HospitalDescriptionCell.h"

@implementation HospitalDescriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

-(void)configureCell:(id)model {
    HospitalDescriptionModel *descriptionModel = (HospitalDescriptionModel *)model;
    if (descriptionModel) {
        self.hospitalInformationLabel.text = descriptionModel.hospitalDescription;
    }
}


@end
