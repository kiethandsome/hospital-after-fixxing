//
//  AccountViewController.h
//  Tìm kiếm bệnh viện
//
//  Created by Kiet on 9/8/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "BaseViewController.h"

@interface AccountViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCityLabel;

@end
