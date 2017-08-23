//
//  ApiResponse.h
//  BenhVien-app
//
//  Created by test on 8/4/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiResponse : NSObject

@property (nonatomic, strong) NSDictionary *originalResponse;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSString *message;
@property (nonatomic) BOOL success;

+ (instancetype)initWithResponse:(NSDictionary *)response;

@end
