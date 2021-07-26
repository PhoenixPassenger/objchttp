//
//  ServiceError.h
//  Pods
//
//  Created by Alley Pereira on 23/07/21.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const ObjcHttpErrorDomain;

enum {
    ServiceErrorRequestFailed = 0,
    ServiceErrorMalformedURLRequest = 1,
    ServiceErrorNotFound = 2,
    ServiceErrorBadRequest = 3,
    ServiceErrorUnknownError = 4
};

//Source: https://stackoverflow.com/questions/4654653/how-can-i-use-nserror-in-my-iphone-app
