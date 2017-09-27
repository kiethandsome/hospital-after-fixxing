//
//  Constant.h
//  BenhVien-app
//
//  Created by Kiet on 9/15/17.
//  Copyright © 2017 test. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define UserToken                           @"UserToken"
#define UserId                              @"UserId"
#define UserEmail                           @"UserEmail"
#define UserRole                            @"UserRole"
#define UserFullName                        @"UserFullName"
#define UserCity                            @"UserCity"

typedef enum  {
    REFRESH,
    LOADMORE
}LoadMode;

typedef enum  {
    CITY,
    DISTRICT,
    HOME
}SearchType;

#endif /* Constant_h */
