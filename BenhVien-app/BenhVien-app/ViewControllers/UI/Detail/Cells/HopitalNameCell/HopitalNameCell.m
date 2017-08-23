//
//  HospitalNameCellTableViewCell.m
//  BenhVien-app
//
//  Created by test on 8/18/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "HospitalNameCell.h"

@implementation HospitalNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configureCell:(id)model {
    HospitalNameModel *nameModel = (HospitalNameModel *)model;
    if (nameModel) {
        self.hospitalNameLabel.text = nameModel.name;
    }
}

@end
