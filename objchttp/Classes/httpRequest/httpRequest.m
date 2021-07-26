//
//  httpRequest.m
//  httpz
//
//  Created by Rodrigo Silva Ribeiro on 20/07/21.
//
#import <Foundation/Foundation.h>
#import "httpRequest.h"
#import "ServiceError.h"

@implementation httpRequest

// MARK: - DEBUG Service Errors
- (void)printaErro:(int)code error:(NSError**)error {
    switch (code) {
    case 1:
        *error = [ServiceError requestFailedWithDescription: @"error description here"];
        break;
    case 2:
        *error = [ServiceError malformedURLRequestWithURL: @"htptz\\:goggle.org"];
        break;
    case 404:
        *error = [ServiceError notFound];
        break;
    case 503:
        *error = [ServiceError badRequest];
        break;
    default:
        *error = [ServiceError unknownErrorWithStatusCode: code];
        break;
    }
}

//  (NSString *) getDataFrom:(NSString *)url{
-(void)fetchData:(NSString *)schema
            host: (NSString *)host
     routerParam: (NSString *)routerParam
      completion: (void (^)(NSString*))callbackBlock {

    //NSMutableURLRequest setup
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSMutableString *urlString = schema.mutableCopy;
    [urlString appendString: host];
    [urlString appendString: routerParam];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];

    NSLog(@"\n🚀 GET request %@", urlRequest.description);

    //Request execution
    [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,
                                                                        NSURLResponse *response,
                                                                        NSError *error)  {
        if (error) NSLog(@"GET Request error - %@",error.localizedDescription);
        else {
            //NSLog(@"\n⬇️ Body recebido no retorno da GET request %@", [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding]);

            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:kNilOptions
                                                                      error:&error];

            if (error) NSLog(@"GET JSONSerialization error - %@", error.localizedDescription);
            else callbackBlock(results.description);
        }
        
    }] resume ];
}

-(void)postData: (NSString *)schema
           host: (NSString *)host
    routerParam: (NSString *)routerParam
     completion: (void (^)(NSString*))callbackBlock {

    //URL setup
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSMutableString *urlString = schema.mutableCopy;
    [urlString appendString: host];
    [urlString appendString: routerParam];
    NSURL *url = [NSURL URLWithString:urlString];

    //NSMutableRequest setup
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSError* error;
    NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"first title", @"title",@"1",@"userId", @"aaaaaaaaaaa",@"body", nil];
    if ([NSJSONSerialization isValidJSONObject:userDictionary]) {//validate it
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDictionary options:NSJSONWritingPrettyPrinted error: &error];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:jsonData];

        NSLog(@"\n🚀 POST request %@", urlRequest.description);

        NSLog(@"\n⬆️ Body enviado pra POST request %@", [[NSString alloc] initWithData: urlRequest.HTTPBody encoding:NSUTF8StringEncoding]);

        //Execute Request
        [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,
                                                                            NSURLResponse *response,
                                                                            NSError *error)  {

            if (error) NSLog(@"POST Request error - %@",error.localizedDescription);
            else {
                //NSLog(@"\n⬇️ Body recebido no retorno da POST request %@", [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding]);

                NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:kNilOptions
                                                                          error:&error];

                if (error) NSLog(@"POST JSONSerialization error - %@", error.localizedDescription);
                else callbackBlock(results.description);
            }
            
        }] resume ];
    }
}

-(void)putData: (NSString *)schema
          host: (NSString *)host
   routerParam: (NSString *)routerParam
    completion: (void (^)(NSString*))callbackBlock {

    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSMutableString *urlString = schema.mutableCopy;
    [urlString appendString: host];
    [urlString appendString: routerParam];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    NSError* error;
    NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Pikachu",@"name",@"Fullstack", @"job", nil];

    if ([NSJSONSerialization isValidJSONObject:userDictionary]) {
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDictionary options:NSJSONWritingPrettyPrinted error:&error];

        [urlRequest setHTTPMethod:@"PUT"];
        [urlRequest setHTTPBody:jsonData];

        NSLog(@"\n🚀 PUT request %@", urlRequest.description);

        /// Checar o body da request como string
        NSLog(@"\n⬆️ Body enviado pra PUT request %@", [[NSString alloc] initWithData: urlRequest.HTTPBody encoding:NSUTF8StringEncoding]);

        [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,
                                                                            NSURLResponse *response,
                                                                            NSError *error)  {

            if (error) NSLog(@"PUT Request error - %@",error.localizedDescription);
            else {
                //NSLog(@"\n⬇️ Body recebido no retorno da PUT request %@", [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding]);

                NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:kNilOptions
                                                                          error:&error];

                if (error) NSLog(@"PUT JSONSerialization error - %@", error.localizedDescription);
                else callbackBlock(results.description);
            }

        }] resume ];
        
    }
}

-(void)deleteData: (NSString *)schema
             host: (NSString *)host
      routerParam: (NSString *)routerParam
       completion: (void (^)(NSString*))callbackBlock {

    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSMutableString *urlString = schema.mutableCopy;
    [urlString appendString: host];
    [urlString appendString: routerParam];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    [urlRequest setHTTPMethod:@"DELETE"];

    NSLog(@"\n🚀 DELETE request %@", urlRequest.description);

    [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,
                                                                        NSURLResponse *response,
                                                                        NSError *error)  {

        //NSLog(@"\n⏺ Method DELETE successfull");

        if (error) NSLog(@"DELETE Request error - %@",error.localizedDescription);
        else {
            //NSLog(@"\n⬇️ Body recebido no retorno da DELETE request %@", [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding]);

            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:kNilOptions
                                                                      error:&error];

            if (error) NSLog(@"DELETE JSONSerialization error - %@", error.localizedDescription);
            else callbackBlock(results.description);
        }

    }] resume ];

}

@end

// MARK: ToDo
// -> Tratar query params dos métodos
