//
//  PlacesViewController.m
//  BenhVien-app
//
//  Created by Kiet on 9/11/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "PlacesViewController.h"


@interface PlacesViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    UITextField *_searchTextField;
    NSArray *_searchResults;
    HNKGooglePlacesAutocompleteQuery *_query;
}

@end

@implementation PlacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cityTableView.estimatedRowHeight = 45.0;
    [self showBarButtons];
    self.cityTableView.dataSource = self;
    self.cityTableView.delegate = self;
    
    _query = [HNKGooglePlacesAutocompleteQuery sharedQuery];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/* show Done Button and Search text field */

- (void)showBarButtons {
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize: 16]};
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Huỷ"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(cancelButtonAction)];
    [cancelButton setTitleTextAttributes: attribute forState:UIControlStateNormal];
    
    _searchTextField = [self searchBox];
    UIView *wrapperView = [[UIView alloc]initWithFrame:_searchTextField.frame];
    [wrapperView addSubview:_searchTextField];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithCustomView: wrapperView];
    self.navigationItem.rightBarButtonItems = @[cancelButton,searchButton];
}

- (void)cancelButtonAction {
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}

- (UITextField *)searchBox {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width ;
    CGFloat textFieldWidth = (280.0/375.0) *screenWidth;
    UITextField *searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, textFieldWidth, 30.0)];
    searchTextField.borderStyle = UITextBorderStyleNone;
    searchTextField.layer.borderWidth = 0.5;
    searchTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    searchTextField.layer.cornerRadius = 4.0;
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.font = [UIFont systemFontOfSize: 15.0];
    searchTextField.placeholder = @"Tỉnh/Thành phố";
    searchTextField.delegate = self;
    return  searchTextField;
}

#pragma mark - UITextField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *searchText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [[HNKGooglePlacesAutocompleteQuery sharedQuery] fetchPlacesForSearchQuery:searchText
                                                                   completion:^(NSArray *places, NSError *error)  {
                                                                       if (error) {
                                                                           NSLog(@"ERROR: %@", error);
                                                                       } else {
                                                                           for (HNKGooglePlacesAutocompletePlace *place in places) {
                                                                               NSLog(@"%@", place);
                                                                               _searchResults = places;
                                                                               [_cityTableView reloadData];
                                                                           }
                                                                       }
                                                                   }
     ];
    return true;
}

#pragma mark - uitableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CitiesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    HNKGooglePlacesAutocompletePlace *place = _searchResults[indexPath.row];
    cell.citiesNameLabel.text = place.name;
    
    return cell;
}

#pragma mark - UITable View Data Source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HNKGooglePlacesAutocompletePlace *place = _searchResults[indexPath.row];
    if (self.block) {
        self.block(place.name);
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
    }
}


@end
























