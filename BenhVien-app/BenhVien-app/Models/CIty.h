//
//  CIty.h
//  BenhVien-app
//
//  Created by test on 8/14/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CIty : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSMutableArray *district;

+ (instancetype)initWithData:(NSDictionary *)data;

@end
