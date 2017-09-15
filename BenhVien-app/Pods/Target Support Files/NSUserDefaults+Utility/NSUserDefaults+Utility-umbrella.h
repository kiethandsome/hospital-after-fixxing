#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSUserDefaults+StandardUserDefaults.h"
#import "NSUserDefaults+Utility.h"

FOUNDATION_EXPORT double NSUserDefaults_UtilityVersionNumber;
FOUNDATION_EXPORT const unsigned char NSUserDefaults_UtilityVersionString[];

