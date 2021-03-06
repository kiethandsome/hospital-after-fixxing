//
//  ApiRequest.h
//  BenhVien-app
//
//  Created by test on 8/4/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ApiManager.h"


@interface ApiRequest : NSObject

+ (void)loginWithEmail:(NSString *)email  password:(NSString *)password completion:(ApiCompletionBlock)completion;
+ (void)searchHospitalByName: (NSString *)name completion:(ApiCompletionBlock)completion;
+ (void)loadTheCitiesWithCompletion:(ApiCompletionBlock)completion;
+ (void)loadHospitalInfById:(NSString *)ID completion:(ApiCompletionBlock)completion;
+ (void)registerWithEmail:(NSString *)email password:(NSString *)password city:(NSString *)city fullName:(NSString *)fullName completion:(ApiCompletionBlock)completion;
+ (void)changePasswordWithUserId:(NSString *)userId oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword completion:(ApiCompletionBlock)completion;
+ (void)searchTheHospitalByTheCityName:(NSString *)cityName page:(NSInteger)page completion:(ApiCompletionBlock)completion;
+ (void)searchTheHospitalByCityName:(NSString *)cityName district:(NSString *)districtName page:(NSInteger)page completion:(ApiCompletionBlock)completion;

@end
