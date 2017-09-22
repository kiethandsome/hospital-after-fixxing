//
//  ApiRequest.m
//  BenhVien-app
//
//  Created by test on 8/4/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "ApiRequest.h"

@implementation ApiRequest


+ (void)loginWithEmail:(NSString *)email  password:(NSString *)password completion:(ApiCompletionBlock)completion {
    NSDictionary *parameters = @{@"email": email,
                                 @"password": password
                                 };
    [[ApiManager sharedClient] requestApiWithEndpoint:Login
                                               method:POST
                                           parameters:parameters
                                              hasAuth:false
                                           completion:completion ];

}

+ (void)searchHospitalByName:(NSString *)name completion:(ApiCompletionBlock)completion {
    NSDictionary *parameters = @{@"name": name};
    [[ApiManager sharedClient] requestApiWithEndpoint:SearchByName
                                               method:GET
                                           parameters:parameters
                                              hasAuth:true
                                           completion:completion ];
}

+ (void)loadTheCitiesWithCompletion:(ApiCompletionBlock)completion {
    [[ApiManager sharedClient] requestApiWithEndpoint:Cities
                                               method:GET
                                           parameters:nil
                                              hasAuth:true
                                           completion:completion ];
}

+ (void)searchTheHospitalByCityName:(NSString *)cityName district:(NSString *)districtName completion:(ApiCompletionBlock)completion{
    NSDictionary *parameters = @{@"city":cityName, 
                                 @"district": districtName
                                 };
    [[ApiManager sharedClient] requestApiWithEndpoint:HospitalDistrict
                                               method:GET
                                           parameters:parameters
                                              hasAuth:true
                                           completion:completion ];
}

+ (void)searchTheHospitalByTheCityName:(NSString *)cityName completion:(ApiCompletionBlock)completion {
    NSDictionary *parameters = @{@"city":cityName};
    [[ApiManager sharedClient] requestApiWithEndpoint:searchByTheCityName
                                               method:GET
                                           parameters:parameters
                                              hasAuth:true
                                           completion:completion ];
}

+ (void)loadHospitalInfById:(NSString *)ID completion:(ApiCompletionBlock)completion {
    NSDictionary *pr = @{@"id":ID};
    [[ApiManager sharedClient] requestApiWithEndpoint:LoadHospitalById
                                               method:GET
                                           parameters:pr
                                              hasAuth:true
                                           completion:completion ];
}

+ (void)registerWithEmail:(NSString *)email password:(NSString *)password city:(NSString *)city fullName:(NSString *)fullName completion:(ApiCompletionBlock)completion {
    NSDictionary *parameters = @{@"email": email,
                                 @"password" : password,
                                 @"role" : @"email",
                                 @"city": city,
                                 @"fullName": fullName
                                 };
    [[ApiManager sharedClient] requestApiWithEndpoint:Register
                                               method:POST
                                           parameters:parameters
                                              hasAuth:false
                                           completion:completion ];
}

+ (void)changePasswordWithUserId:(NSString *)userId oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword completion:(ApiCompletionBlock)completion {
    NSDictionary *param = @{@"password": oldPassword,
                            @"newPassword": newPassword,
                            @"id": userId
                            };
    [[ApiManager sharedClient] requestApiWithEndpoint:ChangePassword
                                               method:PUT
                                           parameters:param
                                              hasAuth:true
                                           completion:completion ];
}

@end










