//
//  SignUpViewController.m
//  Tìm kiếm bệnh viện
//
//  Created by Kiet on 9/4/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SignUpViewController.h"
#import "ApiRequest.h"
#import "ApiResponse.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.segmentControl addTarget: self action:@selector(segmentAction:) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    if (  self.segmentControl.selectedSegmentIndex == 0) {
        self.title = @"Đăng nhập";
    }else {
        self.title = @"Đăng kí";
    }

    
            /// set attribute for the Bar button.
    NSDictionary *attribute = @{ NSFontAttributeName : [UIFont systemFontOfSize: 16]};
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Huỷ bỏ" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonAction)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Xong" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    [cancelButton setTitleTextAttributes: attribute forState:UIControlStateNormal];
    [doneButton setTitleTextAttributes: attribute forState:UIControlStateNormal];
}

- (void)cancelButtonAction {
    [self dismissViewControllerAnimated: true completion: nil];
}

- (void)doneActionButton {
    
}

- (IBAction)segmentAction:(id)sender {
    if (self.segmentControl.selectedSegmentIndex == 0) {
        [self.signInView setHidden: NO];
        [self.signUpView setHidden: YES];
    }else {
        [self.signInView setHidden: YES];
        [self.signUpView setHidden: NO];
    }

}

@end













