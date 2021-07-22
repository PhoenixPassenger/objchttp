//
//  httpRequest.m
//  httpz
//
//  Created by Rodrigo Silva Ribeiro on 20/07/21.
//
#import <Foundation/Foundation.h>
#import "httpRequest.h"
@implementation httpRequest

-(void)fetchData: (void (^)(NSString*))callbackBlock{
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
        callbackBlock(results[@"title"]);
        
    }] resume ];
}

-(void)postData: (void (^)(NSString*))callbackBlock{ {
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSURL *url = [NSURL URLWithString:@"https://jsonplaceholder.typicode.com/posts"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    NSError* error;
    NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"first title", @"title",@"1",@"userId", @"aaaaaaaaaaa",@"body", nil];//if your json structure is something like {"title":"first title","blog_id":"1"}
    if ([NSJSONSerialization isValidJSONObject:userDictionary]) {//validate it
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDictionary options:NSJSONWritingPrettyPrinted error: &error];
        
        //        NSData *postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:jsonData];
        
        [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)  {
            
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@", results.description);
            
        }] resume ];
    }
}}

-(void)putData: (void (^)(NSString*))callbackBlock{ {
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSURL *url = [NSURL URLWithString:@"https://reqres.in/api/users/2"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    NSError* error;
    //NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"title",@"titulo aqui",@"body", @"um texto aqui", nil];
    NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Pikachu",@"name",@"Fullstack", @"job", nil];

    if ([NSJSONSerialization isValidJSONObject:userDictionary]) {
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDictionary options:NSJSONWritingPrettyPrinted error:&error];

        [urlRequest setHTTPMethod:@"PUT"];
        [urlRequest setHTTPBody:jsonData];

        /// Checar o body da request como string
        NSLog(@"\n⬆️ Body enviado pra request %@", [[NSString alloc] initWithData: urlRequest.HTTPBody encoding:NSUTF8StringEncoding]);

        [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)  {
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"\n⬇️ Body recebido no retorno da request %@", results.description);

        }] resume ];
        
    }
}}

-(void)deleteData: (void (^)(NSString*))callbackBlock{  {
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSURL *url = [NSURL URLWithString:@"https://reqres.in/api/users/2"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    [urlRequest setHTTPMethod:@"DELETE"];

    [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)  {
        NSLog(@"\n⏺ Method DELETE successfull");

    }] resume ];

}}

@end

// MARK: ToDo
// -> Tratar query params dos métodos
