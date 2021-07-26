//
//  genericHttp.m
//  objchttp
//
//  Created by Alley Pereira on 23/07/21.
//

#import <Foundation/Foundation.h>
#import "genericHttp.h"

@implementation genericHttp : NSObject

//- (void)get_data:(NSString *)size completionHandler:(void (^)(NSArray *array))completionHandler {
//    // ...
//    [NSURLConnection sendAsynchronousRequest:url_request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        // ...
//        completionHandler(array);
//        // ...
//    }];
//}


- (void)getDataFrom:(NSString *)url withBody:(NSData *)body {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:body];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[body length]] forHTTPHeaderField:@"Content-Length"];
    [request setURL:[NSURL URLWithString:url]];

    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;

        if ( httpResponse.statusCode >= 200 && httpResponse.statusCode < 300) {
            NSLog(@"Error getting %@, HTTP status code %li", url, (long) httpResponse.statusCode);
        }

    }] resume];

}




//- (NSString *) getDataFrom:(NSString *)url{
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setHTTPMethod:@"GET"];
//    [request setURL:[NSURL URLWithString:url]];
//
//    NSError *error = nil;
//    NSHTTPURLResponse *responseCode = nil;
//
////    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
//
////    [[NSData *oResponseData = [NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
//
//    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//
////        if([responseCode statusCode] != 200){
////            NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
////            return nil;
//
//        if ([response.statusCode] >=200 && [response.statusCode] <300)
//            NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
//            //            return nil;
////        }
//
//    }] resume];
//
//
//        return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
//
//
//    }] resume];

//}

@end
