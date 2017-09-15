//
//  UserDataManager.h
//  BenhVien-app
//
//  Created by Kiet on 9/15/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataManager : NSObject

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *fullName;

+ (instancetype)sharedClient;
- (void)setUserData:(NSDictionary *)data;
- (void)clearUserData;

@end
