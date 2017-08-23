//
//  HospitalTableViewCell.h
//  BenhVien-app
//
//  Created by test on 7/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hospital.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HospitalTableViewCell : UITableViewCell 

@property (weak, nonatomic) IBOutlet UILabel *HospitalName;
@property (weak, nonatomic) IBOutlet UILabel *HospitalPhone;
@property (weak, nonatomic) IBOutlet UILabel *HospitalAddress;
@property (weak, nonatomic) IBOutlet UIImageView *hospitalImageView;

- (void)setDataForCell:(id)data;

@end
