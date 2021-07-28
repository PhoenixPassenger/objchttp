//
//  ServiceError.m
//  objchttp
//
//  Created by Alley Pereira on 23/07/21.
//

#import <Foundation/Foundation.h>
#import "serviceError.h"

NSString *const ObjcHttpErrorDomain = @"org.cocoapods.objchttp";

@implementation serviceError

+(NSError *)requestFailedWithDescription:(NSString *)description {
    return [NSError errorWithDomain: ObjcHttpErrorDomain
                               code: 0
                           userInfo:@{
                               NSLocalizedDescriptionKey: [NSString stringWithFormat:
                                                           @"Could not run request because: %@.", description]
                           }
            ];
}

+(NSError *)malformedURLRequestWithURL:(NSString *)url {
    return [NSError errorWithDomain: ObjcHttpErrorDomain
                               code: 1
                           userInfo:@{
                               NSLocalizedDescriptionKey: [NSString stringWithFormat:
                                                           @"Could not build request with url %@.", url]
                           }
            ];
}

+(NSError *)notFound {
    return [NSError errorWithDomain: ObjcHttpErrorDomain
                               code: 2
                           userInfo:@{
                               NSLocalizedDescriptionKey:
                                   @"The Request returned status code 404, the route was not found."
                           }
            ];
}

+(NSError *)badRequest {
    return [NSError errorWithDomain: ObjcHttpErrorDomain
                               code: 3
                           userInfo:@{
                               NSLocalizedDescriptionKey:
                                   @"The Request returned status code 400, Bad Request."
                           }
            ];
}


+(NSError *)unknownErrorWithStatusCode:(int)statusCode {
    return [NSError errorWithDomain: ObjcHttpErrorDomain
                               code: 4
                           userInfo:@{
                               NSLocalizedDescriptionKey: [NSString stringWithFormat:
                                                           @"The Request returned status code %d, unknown meaning.", statusCode]
                           }
            ];
}

@end
