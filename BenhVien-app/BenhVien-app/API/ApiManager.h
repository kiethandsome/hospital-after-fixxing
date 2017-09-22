//
//  ApiManager.h
//  BenhVien-app
//
//  Created by test on 8/4/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "ApiResponse.h"
#import "ApiEndpoint.h"
#import "Hospital.h"

typedef enum {
    GET,
    POST,
    PUT
} Apimethod;

typedef void (^ApiCompletionBlock)(ApiResponse *response, NSError *error);

@interface ApiManager : NSObject

+ (instancetype)sharedClient;

- (void)requestApiWithEndpoint: (NSString *)endpoint method: (Apimethod)method parameters: (NSDictionary *)parameters hasAuth: (BOOL)hasAuth completion: (ApiCompletionBlock)completion;

@end
