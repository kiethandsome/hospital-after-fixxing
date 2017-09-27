//
//  ApiManager.m
//  BenhVien-app
//
//  Created by test on 8/4/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "ApiManager.h"
#import "UserDataManager.h"

@interface ApiManager()

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation ApiManager

// Khoi tao Singleton.

+ (instancetype)sharedClient {
    static ApiManager *_sharedClient = nil;
    static dispatch_once_t onceTonken;
    dispatch_once(&onceTonken, ^{
        _sharedClient = [[ApiManager alloc] init];
        [_sharedClient setupManager];
    });
    return  _sharedClient;
}

- (void)setupManager {
    self.manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
}

- (void)setupHeader {
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.manager.requestSerializer setValue:[self getAccessToken] forHTTPHeaderField:@"Authorization"];
}

- (NSString *)getAccessToken {
    NSString *token = [NSString stringWithFormat:@"JWT %@", [UserDataManager sharedClient].accessToken];
    return token;
}


- (void)requestApiWithEndpoint: (NSString *)endpoint method: (Apimethod)method parameters: (NSDictionary *)parameters hasAuth: (BOOL)hasAuth completion: (ApiCompletionBlock)completion {
    NSString *fullURL = [NSString stringWithFormat:@"%@%@", BaseURL,endpoint];
    if (hasAuth) {
        [self setupHeader];
    }
    switch (method) {
        case GET: {
            [self processGetRequestWithURL:fullURL parameters:parameters completion:completion];
            break;
        }
        case POST: {
            [self processPostRequestWithURL:fullURL parameters:parameters completion:completion];
            break;
        }
        case PUT: {
            [self processPutRequestWithURL:fullURL parameters:parameters completion:completion];
            break;
        }
        default:
            break;
    }
    
}

#pragma mark - GET

- (void)processGetRequestWithURL:(NSString *)url parameters:(NSDictionary *)parameters completion:(ApiCompletionBlock)completion {
    [self.manager GET:url
           parameters:parameters
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                  [self processSuccessWithResponse:responseObject completion:completion];
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  [self processFailureWithError:error completion:completion];
              }];
}

#pragma mark - POST

- (void)processPostRequestWithURL:(NSString *)url parameters:(NSDictionary *)parameters completion:(ApiCompletionBlock)completion {
    [self.manager POST:url
            parameters:parameters
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject)
     {
         [self processSuccessWithResponse:responseObject completion:completion];
     }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [self processFailureWithError:error completion:completion];
     }];
}

#pragma mark - PUT

- (void)processPutRequestWithURL:(NSString *)url parameters:(NSDictionary *)parameters completion:(ApiCompletionBlock)completion {
    [self.manager PUT:url
           parameters:parameters
              success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject)
     {
         [self processSuccessWithResponse:responseObject completion:completion];
     }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  [self processFailureWithError:error completion:completion];
              }];
}

#pragma mark - SUCCESS

- (void)processSuccessWithResponse:(id)responseObject completion:(ApiCompletionBlock)completion {
    NSLog(@"Sucess with response: %@", responseObject);
    ApiResponse *res = [ApiResponse initWithResponse:responseObject];
    if (completion) {
        completion(res, nil);
    }
    
}

#pragma mark - FAILURE

- (void)processFailureWithError:(NSError *)error completion:(ApiCompletionBlock)completion {
    NSLog(@"Failure with response: %@", error);
    if (completion) {
        completion(nil, error);
    }
}



@end




















