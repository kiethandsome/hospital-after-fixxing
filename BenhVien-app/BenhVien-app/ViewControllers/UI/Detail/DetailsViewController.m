//
//  DetailsViewController.m
//  BenhVien-app
//
//  Created by test on 7/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController()

@end

@implementation DetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUserInterface];
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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"cc" message:@"con cac" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"chich" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:true completion:nil];
}

- (NSArray *)setData {
    NSMutableArray *data = [NSMutableArray new];
    
    SlideShowModel *slideShow = [SlideShowModel new];
    [data addObject:slideShow];
    
    HospitalNameModel *hospitalName = [HospitalNameModel new];
    [data addObject:hospitalName];
    
    HospitalAddressModel *hospitalAddress = [HospitalAddressModel new];
    [data addObject:hospitalAddress];
    
    PhoneNumberModel *phoneNumber = [PhoneNumberModel new];
    [data addObject:phoneNumber];
    
    HospitalDescriptionModel *hospitalDescription = [HospitalDescriptionModel new];
        [data addObject:hospitalDescription];
    
    MapModel *map = [MapModel new];
    [data addObject:map];
    
    return data;
}

- (void)loadHospitalData {
    [self showHUD];
    [ApiRequest loadHospitalInfById:self.currentHospital._id completion:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
        if (!error){
            Hospital *hospital = [Hospital initWithResponse:[response.data objectForKey:@"hospitalInfo"]];
            [self displayHospitalInfo:hospital];
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
    [data addObject:map];
    
    [self.searchResultTableView addItems:data];
}

@end
































