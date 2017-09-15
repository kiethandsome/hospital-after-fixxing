//
//  CIty.m
//  BenhVien-app
//
//  Created by test on 8/14/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "CIty.h"

@implementation CIty

+ (instancetype)initWithData:(NSDictionary *)data {
    CIty *newCity = [[CIty alloc]init];
    [newCity parseForJSONWith:data];
    return newCity;
}

- (void)parseForJSONWith:(NSDictionary *)data {
    NSString *cityName = [data objectForKey:@"name"];
    if (cityName && ![cityName isKindOfClass:[NSNull class]]) {
        self.name = [cityName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    } else {
        cityName = @"";
    }
    NSArray *districts = [data valueForKey:@"districtes"];
    if (districts.count > 0) {
        
        self.district = [NSMutableArray new];
        for (NSDictionary *districtData in districts) {
            NSString *districtName = [ districtData objectForKey:@"name"];
            [self.district addObject:[districtName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        }
    }else {
        self.district = [NSMutableArray new];
    }
    
}

@end
