//
//  httpRequest.m
//  http
//
//  Created by Rodrigo Silva Ribeiro on 20/07/21.
//
#import <Foundation/Foundation.h>
#import "httpRequest.h"
@implementation httpRequest
-(void)fetchData: (void (^)(NSString*))callbackBlock{
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSMutableString *urlString = _schema.mutableCopy;
    [urlString appendString:_host];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"GET"];
    [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)  {
        
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        callbackBlock(results[@"title"]);
        
    }] resume ];
}

-(void)postData: (void (^)(NSString*))callbackBlock;{
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSURL *url = [NSURL URLWithString:@"https://jsonplaceholder.typicode.com/posts"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSError* error;
    NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"first title", @"title",@"1",@"userId", @"aaaaaaaaaaa",@"body", nil];
    if ([NSJSONSerialization isValidJSONObject:userDictionary]) {//validate it
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDictionary options:NSJSONWritingPrettyPrinted error: &error];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:jsonData];
        
        [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)  {
            
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(results.description);
            callbackBlock(results.description);
            
        }] resume ];
    }
}
@end

