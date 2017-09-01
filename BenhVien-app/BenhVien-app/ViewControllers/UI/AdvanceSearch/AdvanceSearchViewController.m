//
//  AdvanceSearchViewController.m
//  BenhVien-app
//
//  Created by test on 7/28/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "AdvanceSearchViewController.h"

@interface AdvanceSearchViewController ()<IQDropDownTextFieldDelegate, IQDropDownTextFieldDataSource>
{
    NSMutableArray *_cities;
}
@end

@implementation AdvanceSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tìm kiếm nâng cao";
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    [self showBackButtonItem];
    // setup city container view
    self.CityContainerView.layer.cornerRadius = 4.0;
    self.districtContainerView.layer.cornerRadius = 4.0;
    self.searchButton.layer.cornerRadius = 4.0;
    
    _cities = [NSMutableArray new];
    
    // delegate
    self.cityPicker.delegate = self;
    self.cityPicker.dataSource = self;
    
    // Load Data
    [self getCitiesFromServer];
}

#pragma mark Get the cities from the JSON file.

- (NSMutableArray *)readCitiesFromJsonFile {
    NSMutableArray *cities = [NSMutableArray new];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"json"];
    NSString *JsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data = [JsonString dataUsingEncoding:NSUTF8StringEncoding];

    NSDictionary *JSONDIict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *cityArray = [JSONDIict objectForKey:@"cities"];
    for (NSDictionary *citiesDict in cityArray) {
        CIty *city = [CIty initWithData:citiesDict];
        [cities addObject:city];
    }
    return cities;
}

                                                    // Setup both 2 IQDropDown-s type.
- (void)setupCityDropDownAndDistrictDropDown {
    self.cityPicker.isOptionalDropDown = NO;
    self.districtPicker.isOptionalDropDown = NO;
    
    [self.cityPicker setItemList:[self getNameOfCities]];
    [self.districtPicker setItemList:[self getDistrictNameFromCity:_cities[0]]];
    
}

                                                    // Get names of cities.
- (NSArray *)getNameOfCities {
    NSMutableArray *cityNames = [ NSMutableArray new];
    for (CIty *city in _cities){
        [cityNames addObject:city.name];
    }
    return [cityNames mutableCopy];
}

                                                    // Get districts from cityNames.
- (NSArray *)getDistrictNameFromCity:(CIty *)city {
    NSMutableArray *districtName = [NSMutableArray new];
    [districtName addObjectsFromArray:city.district];
    [districtName insertObject:@"Tất cả Quận/Huyện" atIndex:0];
    return [districtName mutableCopy];
}


#pragma mark - Get the Cities by The API Request to Server

- (void)getCitiesFromServer {
    [self showHUD];
    
    //// Đây là hàm AsynTask nên nó sẽ ko theo thứ tự từ trên xuóng như các hàm bth, mà bỏ qa đoạn code bên dưới, chờ response từ server.
    //// khi nhận dc response từ server thì mới đi vào hàm dưới đây.
    
    [ApiRequest loadTheCitiesWithCompletion:^(ApiResponse *response, NSError *error) {
        NSArray *citiesArray = [response.data objectForKey:@"cities"];
        if (citiesArray.count > 0){
            [self hideHUD];
            for (NSDictionary *cityDict in citiesArray) {
                CIty *aCity = [CIty initWithData:cityDict];
                [_cities addObject:aCity];
            }
            [self setupCityDropDownAndDistrictDropDown];
        }else {
            [self showAlertWithTitle:@"Lỗi!" message:error.localizedDescription];
        }
    }];
}


#pragma mark IQDropDownTextField Delegate

                                        // Khi thay đổi giá trị của City thì District cũng thay đổi theo
- (void)textField:(nonnull IQDropDownTextField *)textField didSelectItem:(NSString *)item {
    if(textField == self.cityPicker)
    {
        CIty *city = _cities[textField.selectedRow];
        [self.districtPicker setItemList:[self getDistrictNameFromCity:city]];
        [self.districtPicker setSelectedRow:0];
    }
    else {
        [self showAlertWithTitle:@"" message:@""];
    }
}

#pragma mark IBActions

- (IBAction)searchPressed:(UIButton *)sender {
    NSString *cityName = self.cityPicker.selectedItem;
    NSString *districtName = self.districtPicker.selectedItem;
    
    if ([districtName isEqualToString:@"Tất cả Quận/Huyện"]){
        [self searchHospitalByCityName:cityName];
    }else {
        [self searchHospitalByCityName:cityName district:districtName];
    }
}

                                                //// Tìm bệnh viện bằng City name và district.
- (void)searchHospitalByCityName:(NSString *)cityName district:(NSString *)districtName {
    
    [ApiRequest searchTheHospitalByCityName:cityName district:districtName completion:^(ApiResponse *response, NSError *error) {
        NSArray *hospitalArray = [response.data objectForKey:@"hospitals"];
        if (hospitalArray > 0) {
            NSMutableArray *hosArray = [NSMutableArray new];
            for (NSDictionary *dict in hospitalArray) {
                Hospital *aHospital = [Hospital initWithResponse:dict];
                [hosArray addObject:aHospital];
            }
            SearchResultViewController *vc = (SearchResultViewController *)[SearchResultViewController instanceFromStoryboardName:@"Home"];
            vc.hospitals = hosArray;
            [self.navigationController pushViewController:vc animated:true];
            
        }else {
            [self showAlertWithTitle:@"Thông báo" message:@"Không tìm thấy bệnh viện bạn yêu cầu!"];
        }
    }];
}

                                            // Tìm bệnh viện chỉ bằng city name.
- (void)searchHospitalByCityName:(NSString *)cityName {
    [ApiRequest searchTheHospitalByTheCityName:cityName completion:^(ApiResponse *response, NSError *error) {
        NSArray *hospitalArray = [response.data valueForKey:@"hospitals"];
        if (hospitalArray > 0) {
            NSMutableArray *hosArray = [NSMutableArray new];
            for (NSDictionary *dict in hospitalArray) {
                Hospital *aHospital = [Hospital initWithResponse:dict];
                [hosArray addObject:aHospital];
            }
                //// Using this code line below,
                //// we dont need to name the identifier for the View controller.
            SearchResultViewController *vc = (SearchResultViewController *)[SearchResultViewController instanceFromStoryboardName:@"Home"];
            vc.hospitals = hosArray;
            [self.navigationController pushViewController:vc animated:true];
        }else {
            [self showAlertWithTitle:@"Thông đít" message:@"Không tìm thấy bệnh viện bạn yêu cầu!"];
        }
    }];
}


@end










