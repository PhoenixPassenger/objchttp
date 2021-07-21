//
//  httpRequest.m
//  http
//
//  Created by Rodrigo Silva Ribeiro on 20/07/21.
//
#import <Foundation/Foundation.h>
#import "httpRequest.h"
@implementation httpRequest
-(void)fetchData: (BOOL *) flag {
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
        NSURL *url = [NSURL URLWithString:@"https://jsonplaceholder.typicode.com/posts/1"];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

//        NSString *postParams = @"";
//        NSData *postData = [postParams dataUsingEncoding:NSUTF8StringEncoding];

        [urlRequest setHTTPMethod:@"GET"];
//        [urlRequest setHTTPBody:postData];

    [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)  {

                NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSLog(results[@"body"]);
                *flag = TRUE;
                
            }] resume ];
}
@end

