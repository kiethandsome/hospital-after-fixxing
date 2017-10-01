//
//  AdvanceSearchViewController.h
//  BenhVien-app
//
//  Created by test on 7/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchResultViewController.h"
#import "IQDropDownTextField.h"
#import "Declaration.h"
#import "CIty.h"
#import "ApiRequest.h"
#import "Constant.h"

@class HomeViewController;



@interface AdvanceSearchViewController : BaseViewController

@property (strong, nonatomic) HomeViewController *prevViewController;

@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger totalPage;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *district;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIView *CityContainerView;
@property (weak, nonatomic) IBOutlet UIView *districtContainerView;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *cityPicker;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *districtPicker;
@property (nonatomic) Block sum; 
@property (nonatomic) Cong2So phepCong;

@end
