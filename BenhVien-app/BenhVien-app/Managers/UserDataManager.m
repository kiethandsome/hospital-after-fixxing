//
//  UserDataManager.m
//  BenhVien-app
//
//  Created by Kiet on 9/15/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "UserDataManager.h"
#import "Constant.h"
#import "NSUserDefaults+Utility.h"

@implementation UserDataManager
@synthesize accessToken = _accessToken;
@synthesize userId = _userId;
@synthesize fullName = _fullName;
@synthesize city = _city;
@synthesize role = _role;
@synthesize email = _email;

                // Tạo một biến kiểu UserDataManager ...

+ (instancetype)sharedClient {
    static UserDataManager *_sharedClient = nil;
    static dispatch_once_t oneToken;                /// kiềm tra xem đã alloc chưa (đã lưu trên vùng nhớ chưa)
    dispatch_once(&oneToken, ^{                     /// nếu chưa thì khai báo, rồi thì ko khởi tạo nữa.
        _sharedClient = [[UserDataManager alloc] init];
    });
    return _sharedClient;
                            /// Đây là cấu trúc của Singleton (học thuộc lòng).
}

                // Parse dữ liệu vào các thuộc tính của UserDataManager.

- (void)setUserData:(NSDictionary *)data {
    self.accessToken = [data objectForKey:@"token"];
    self.email = [data objectForKey:@"email"];
    self.fullName = [data objectForKey:@"fullName"];
    self.userId = [data objectForKey:@"userId"];
    self.role = [data objectForKey:@"role"];
    self.city = [data objectForKey:@"city"];
}

- (void)clearUserData {
    [NSUserDefaults setObject:nil forKey:UserToken];
    [NSUserDefaults setObject:nil forKey:UserRole];
    [NSUserDefaults setObject:nil forKey:UserCity];
    [NSUserDefaults setObject:nil forKey:UserFullName];
    [NSUserDefaults setObject:nil forKey:UserId];
    [NSUserDefaults setObject:nil forKey:UserEmail];
}

                // Gán các dữ liệu của thuộc tính của UserDataManager vào UserDefalt bằng  "NSUserDefaults+Utility.h".
                // Over write lại Setter và Getter

#pragma mark - Access Token

- (void)setAccessToken:(NSString *)accessToken {
    _accessToken = accessToken;
    [NSUserDefaults setObject:accessToken forKey:UserToken];
}

- (NSString *)accessToken {
    NSString *accessToken = [NSUserDefaults stringForKey:UserToken];
    if (accessToken) {
        return accessToken;
    }else {
        return @"";
    }
}

#pragma mark - Full Name

- (void)setFullName:(NSString *)fullName {
    _fullName  = fullName;
    [NSUserDefaults setObject:fullName forKey:UserToken];
}

- (NSString *)fullName {
    NSString *fullName = [NSUserDefaults stringForKey:UserToken];
    if (fullName) {
        return fullName;
    }else {
        return @"";
    }
}

#pragma mark - User Id

- (void)setUserId:(NSString *)userId {
    _userId = userId;
    [NSUserDefaults setObject:userId forKey:UserId];
}

- (NSString *)userId {
    NSString *userId = [NSUserDefaults stringForKey:UserId];
    if (userId){
        return userId;
    }else {
        return @"";
    }
}

#pragma mark - City

- (void)setCity:(NSString *)city {
    _city = city;
    [NSUserDefaults setObject:city forKey:UserCity];
}

- (NSString *)city {
    NSString *city = [NSUserDefaults stringForKey:UserCity];
    if (city){
        return city;
    }else {
        return @"";
    }
}


#pragma mark - Role 

- (void)setRole:(NSString *)role {
    _role = role;
    [NSUserDefaults setObject:role forKey:UserRole];
}

- (NSString *)role {
    NSString *role = [NSUserDefaults stringForKey:UserRole];
    if (role){
        return role;
    }else {
        return @"";
    }
}

#pragma mark - Email

- (void)setEmail:(NSString *)email {
    _email = email;
    [NSUserDefaults setObject:email forKey:UserEmail];
}

- (NSString *)email {
    NSString *email= [NSUserDefaults stringForKey:UserEmail];
    if (email){
        return email;
    }else {
        return @"";
    }
}

@end












