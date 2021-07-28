//
//  ServiceError.h
//  Pods
//
//  Created by Alley Pereira on 23/07/21.
//

#import <Foundation/Foundation.h>

@interface serviceError: NSObject

+(NSError *)requestFailedWithDescription:(NSString *)description;
+(NSError *)malformedURLRequestWithURL:(NSString *)url;
+(NSError *)notFound;
+(NSError *)badRequest;
+(NSError *)unknownErrorWithStatusCode:(int)statusCode;

@end
