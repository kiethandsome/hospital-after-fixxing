//
//  DetailsViewController.m
//  BenhVien-app
//
//  Created by test on 7/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIAlertController+Blocks.h"

@interface DetailsViewController()

@end

@implementation DetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHospitalData];
    
            // HLTableView.
    self.searchResultTableView.rowHeight = UITableViewAutomaticDimension;
    self.searchResultTableView.estimatedRowHeight = 100.0;
            // Đăng kí cell với lớp tương ứng quản lí.
    self.searchResultTableView.allowsSelection = NO;  // ko cho click chon.
    [self.searchResultTableView registerCell:[SlideShowCell class] forModel:[SlideShowModel class]];
    [self.searchResultTableView registerCell:[HospitalNameCell class] forModel:[HospitalNameModel class]];
    [self.searchResultTableView registerCell:[HospitalAddressCell class] forModel:[HospitalAddressModel class]];
    [self.searchResultTableView registerCell:[PhoneNumberCell class] forModel:[PhoneNumberModel class]];
    [self.searchResultTableView registerCell:[HospitalDescriptionCell class] forModel:[HospitalDescriptionModel class]];
    [self.searchResultTableView registerCell:[MapCell class] forModel:[MapModel class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    [self showBackButtonItem];
    [self showLocationFindingButton];
    if (self.currentHospital) {
        self.title = self.currentHospital.name;
    }
}

        // Hiển thị nút tìm đường.
- (void)showLocationFindingButton {
    UIBarButtonItem *findingLocationButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"direction-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(findingLocationButtonPressed:)];
    self.navigationItem.rightBarButtonItem = findingLocationButton;
}

- (IBAction)findingLocationButtonPressed:(id)sender{
    LocationViewController *nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationViewController"];
    nextView.currentHospital = self.currentHospital;
    [self.navigationController pushViewController: nextView animated: true];
}

- (void)loadHospitalData {
    [self showHUD];
    [self.searchResultTableView setHidden: YES];
    [ApiRequest loadHospitalInfById:self.currentHospital._id completion:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
        [self.searchResultTableView setHidden: NO];
        if (!error){
            Hospital *hospital = [Hospital initWithResponse:[response.data objectForKey:@"hospitalInfo"]];
            [self displayHospitalInfo:hospital];
                /// Because the currentHospital from the SearchResult doesnt have longgitude and latitude,
                /// this code Line below assign the hospital variable from 'hospitalInfo' to the currentHospital.
            self.currentHospital = hospital;
        } else {
            [self showAlertWithTitle:@"Lỗi" message:response.message];
        }
    }];
}

-(void)displayHospitalInfo:(Hospital *)hospital {
    NSMutableArray *data = [NSMutableArray new];
    
    SlideShowModel *slideShow = [SlideShowModel new];
    slideShow.images = hospital.images;
    [data addObject:slideShow];
    
    HospitalNameModel *hospitalName = [HospitalNameModel new];
    hospitalName.name = hospital.name;
    [data addObject:hospitalName];
    
    HospitalAddressModel *hospitalAddress = [HospitalAddressModel new];
    hospitalAddress.address = hospital.street;
    [data addObject:hospitalAddress];
    
    PhoneNumberModel *phoneNumber = [PhoneNumberModel new];
    phoneNumber.phoneNumbers = hospital.phones;
    [data addObject:phoneNumber];
    
    HospitalDescriptionModel *hospitalDescription = [HospitalDescriptionModel new];
    hospitalDescription.hospitalDescription = hospital.hospitalDescription;
    [data addObject:hospitalDescription];
    
    MapModel *map = [MapModel new];
    map.longatitude = hospital.longitude;
    map.latitude = hospital.latitude;
    map.hospitalName = hospital.name;
    [data addObject:map];
    
    [self.searchResultTableView addItems:data];
}

- (IBAction)callingButtonAction:(UIButton *)sender {
    NSString *hospitalPhoneNumber = self.currentHospital.phones[0];
    if (_currentHospital.phones.count == 0 ) {
        NSString *alertTittle = @"Xin lỗi!";
        NSString *alertMess = @"Bệnh viện này chưa được cập nhât số điện thoại";
        [self showAlertWithTitle:alertTittle message:alertMess];
    } else {
        [UIAlertController showAlertInViewController:self
                                           withTitle:@"Xác nhận"
                                             message:@"Mở ứng dụng gọi điện?"
                                   cancelButtonTitle:@"Không"
                              destructiveButtonTitle:@"Có"
                                   otherButtonTitles:nil
                                            tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                if (buttonIndex == controller.destructiveButtonIndex) {
                                                    NSString *phone =  [NSString stringWithFormat:@"tel:%@", hospitalPhoneNumber];
                                                    NSURL *URL = [NSURL URLWithString:phone];
                                                    [[UIApplication sharedApplication] openURL:URL];
                                                }
                                            }];
    }
}

- (IBAction)messageButonAction:(UIButton *)sender {
    
}


@end
































