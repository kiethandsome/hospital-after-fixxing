//
//  HomeViewController.h
//  BenhVien-app
//
//  Created by test on 7/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hex.h"
#import "BaseViewController.h"
#import "AdvanceSearchViewController.h"
#import "ApiRequest.h"
#import "ApiResponse.h"
#import "Hospital.h"

//typedef NSString *(^sum)(NSString *a, NSString *b); (KIEu khai bao Block).

@interface HomeViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *advanceSearchButton;
@property (nonatomic) BOOL isMenuDisplayed;

@end
