//
//  ApiManager.m
//  BenhVien-app
//
//  Created by test on 8/4/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "ApiManager.h"

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
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
}

// CÁI NỒI GÌ ĐÂY ?

- (void)requestApiWithEndpoint: (NSString *)endpoint method: (Apimethod)method parameters: (NSDictionary *)parameters completion: (ApiCompletionBlock)completion {
    NSString *fullURL = [NSString stringWithFormat:@"%@%@", BaseURL,endpoint];
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
         [self processFailureWithError:error completion:nil];
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
        [self processFailureWithError:error completion:nil];
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

//Token

//- (NSString *)getToken {
//    return  @"JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyIkX18iOnsic3RyaWN0TW9kZSI6dHJ1ZSwic2VsZWN0ZWQiOnt9LCJnZXR0ZXJzIjp7fSwiX2lkIjoiNTk2ZjY5OTAxMDlkMDAwMDA0MWY0N2VhIiwid2FzUG9wdWxhdGVkIjpmYWxzZSwiYWN0aXZlUGF0aHMiOnsicGF0aHMiOnsicGFzc3dvcmQiOiJpbml0IiwiY2l0eSI6ImluaXQiLCJmdWxsTmFtZSI6ImluaXQiLCJlbWFpbCI6ImluaXQiLCJyb2xlIjoiaW5pdCIsIl9fdiI6ImluaXQiLCJpc0FjdGl2YXRlZCI6ImluaXQiLCJfaWQiOiJpbml0In0sInN0YXRlcyI6eyJpZ25vcmUiOnt9LCJkZWZhdWx0Ijp7fSwiaW5pdCI6eyJfX3YiOnRydWUsInJvbGUiOnRydWUsImZ1bGxOYW1lIjp0cnVlLCJjaXR5Ijp0cnVlLCJpc0FjdGl2YXRlZCI6dHJ1ZSwicGFzc3dvcmQiOnRydWUsImVtYWlsIjp0cnVlLCJfaWQiOnRydWV9LCJtb2RpZnkiOnt9LCJyZXF1aXJlIjp7fX0sInN0YXRlTmFtZXMiOlsicmVxdWlyZSIsIm1vZGlmeSIsImluaXQiLCJkZWZhdWx0IiwiaWdub3JlIl19LCJwYXRoc1RvU2NvcGVzIjp7fSwiZW1pdHRlciI6eyJkb21haW4iOm51bGwsIl9ldmVudHMiOnt9LCJfZXZlbnRzQ291bnQiOjAsIl9tYXhMaXN0ZW5lcnMiOjB9fSwiaXNOZXciOmZhbHNlLCJfZG9jIjp7InJvbGUiOiJlbWFpbCIsIl9fdiI6MCwiZnVsbE5hbWUiOiJIYW8gTGUiLCJjaXR5IjoiVHJ1bmcgVMOibSBWxINuIEjDs2EgUXXhuq1uIDksIMSQ4buXIFh1w6JuIEjhu6NwLCBQaMaw4bubYyBMb25nIEIsIEhvIENoaSBNaW5oLCBWaWV0bmFtIiwiaXNBY3RpdmF0ZWQiOnRydWUsInBhc3N3b3JkIjoiJDJhJDEwJFhCRUt6QVY1UHZPbmdlRnhKZ1JEYWVVdGpCNWZMNWw0bENlOE1lZmxtUXhzRkhhQXNaSHRDIiwiZW1haWwiOiJoYW9sZUBnbWFpbC5jb20iLCJfaWQiOiI1OTZmNjk5MDEwOWQwMDAwMDQxZjQ3ZWEifSwiJGluaXQiOnRydWUsImlhdCI6MTUwMjI4MDMxN30.r8K3ozNDFnbyBZzvxgCWVzK3xXhnyuDN99FsFtnU0qk";
//}
//
//- (void)setHeader {
//    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [self.manager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
//}

@end




















