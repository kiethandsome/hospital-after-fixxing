//
//  Hospital.h
//  BenhVien-app
//
//  Created by test on 7/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiResponse.h"

@interface Hospital : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *hospitalDescription;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong ) NSArray *phones;
@property (nonatomic, strong) NSString *street;

+ (instancetype)initWithResponse:(NSDictionary *)response;

@end
