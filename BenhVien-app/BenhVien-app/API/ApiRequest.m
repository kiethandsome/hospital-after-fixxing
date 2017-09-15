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
                                           completion:completion];
}

+ (void)searchHospitalByName:(NSString *)name completion:(ApiCompletionBlock)completion {
    NSDictionary *parameters = @{@"name": name};
    [[ApiManager sharedClient] requestApiWithEndpoint:SearchByName
                                               method:GET
                                           parameters:parameters
                                           completion:completion];
}

+ (void)loadTheCitiesWithCompletion:(ApiCompletionBlock)completion {
    [[ApiManager sharedClient] requestApiWithEndpoint:Cities
                                               method:GET
                                           parameters:nil
                                           completion:completion];
}

+ (void)searchTheHospitalByCityName:(NSString *)cityName district:(NSString *)districtName completion:(ApiCompletionBlock)completion{
    NSDictionary *parameters = @{@"city":cityName, 
                                 @"district": districtName
                                 };
    [[ApiManager sharedClient] requestApiWithEndpoint:HospitalDistrict
                                               method:GET
                                           parameters:parameters
                                           completion:completion];
}

+ (void)searchTheHospitalByTheCityName:(NSString *)cityName completion:(ApiCompletionBlock)completion {
    NSDictionary *parameters = @{@"city":cityName};
    [[ApiManager sharedClient] requestApiWithEndpoint:searchByTheCityName
                                               method:GET
                                           parameters:parameters
                                           completion:completion];
}

+ (void)loadHospitalInfById:(NSString *)ID completion:(ApiCompletionBlock)completion {
    NSDictionary *pr = @{@"id":ID};
    [[ApiManager sharedClient] requestApiWithEndpoint:LoadHospitalById
                                               method:GET
                                           parameters:pr
                                           completion:completion];
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
                                           completion:completion];
}

+ (void)changePasswordWithEmail:(NSString *)email completion:(ApiCompletionBlock)completion {
    NSDictionary *param = @{@"email": email};
    [[ApiManager sharedClient] requestApiWithEndpoint:@""
                                               method:POST
                                           parameters:param
                                           completion:completion];
}


@end










