//
//  Hospital.m
//  BenhVien-app
//
//  Created by test on 7/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "Hospital.h"

@implementation Hospital

+ (instancetype)initWithResponse:(NSDictionary *)response {
    Hospital *hospital = [[Hospital alloc] init];
    [hospital parseResponse:response];
    return hospital;
}

- (void)parseResponse:(NSDictionary *)response {
    NSString *_id = [response objectForKey:@"_id"];
    if (_id && ![_id isKindOfClass:[NSNull class]]) {
        self._id = _id;
    }
    
    NSString *avatar = [response objectForKey:@"avatar"];
    if (avatar && ![avatar isKindOfClass:[NSNull class]]) {
        self.avatar = avatar;
    } else {
        self.avatar = @"";
    }
    
    NSString *city = [response objectForKey:@"city"];
    if (city && ![city isKindOfClass:[NSNull class]]) {
        self.city = response[city];
    }
    
    NSString *description = [response objectForKey:@"description"];
    if (description && ![description isKindOfClass:[NSNull class]]) {
        self.hospitalDescription = description;
    }
    
    NSString *district = [response objectForKey:@"district"];
    if (district && ![district isKindOfClass:[NSNull class]]) {
        self.district = district;
    }
    
    NSArray *images = [response objectForKey:@"images"];
    if (images && ![images isKindOfClass:[NSNull class]]) {
        self.images = images;
    }
    
    NSString *latitude = [response objectForKey:@"latitude"];
    self.latitude = [latitude doubleValue];
    
    NSString *longitude = [response objectForKey:@"longitude"];
    self.longitude = [longitude doubleValue];
    
    NSString *name = [response objectForKey:@"name"];
    if (name && ![name isKindOfClass:[NSNull class]]) {
        self.name = name;
    }
    
    NSArray *phones = [response objectForKey:@"phones"];
    if (phones && ![phones isKindOfClass:[NSNull class]]) {
        self.phones = phones;
    } else {
        phones = [NSArray new];
    }
    
    NSString *street = [response objectForKey:@"street"];
    if (street && ![street isKindOfClass:[NSNull class]]) {
        self.street = street;
    }
}

@end
