//
//  httpRequest.m
//  httpz
//
//  Created by Rodrigo Silva Ribeiro on 20/07/21.
//
#import <Foundation/Foundation.h>
#import "serviceError.h"
#import "httpRequest.h"


@implementation httpRequest

// MARK: - DEBUG Service Errors
- (void)printErrorWithStatusCode:(long)code error:(NSError**)error {
    switch (code) {
    case 404:
        *error = [serviceError notFound];
        break;
    case 400:
        *error = [serviceError badRequest];
        break;
    default:
        *error = [serviceError unknownErrorWithStatusCode: (int)code];
        break;
    }
}

-(void)fetchData: (NSString *)routerParam
      completion: (void (^)(NSString*))callbackBlock {

    //NSMutableURLRequest setup
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSMutableString *urlString = _schema.mutableCopy;
    [urlString appendString: _host];
    [urlString appendString: routerParam];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSLog(@"\n🚀 GET request %@", urlRequest.description);

    //Request execution
    [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,
                                                                        NSURLResponse *response,
                                                                        NSError *error)  {
        if (error) NSLog(@"GET Request error - %@",
                         [serviceError requestFailedWithDescription:error.localizedDescription]);
        else {
            //NSLog(@"\n⬇️ Body recebido no retorno da GET request %@", [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding]);

            NSError * serializationError;
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:kNilOptions
                                                                      error:&serializationError];

            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
            if (HTTPResponse.statusCode != 200) {
                NSLog(@"GET Response Error");
                [self printErrorWithStatusCode:HTTPResponse.statusCode error:nil];
            }

            if (serializationError) NSLog(@"GET JSONSerialization error - %@", serializationError.localizedDescription);
            else callbackBlock(results.description);
        }
        
    }] resume ];
}

-(void)postData: (NSMutableDictionary *)jsonDict : (NSString *)routerParam
     completion: (void (^)(NSString*))callbackBlock {

    //URL setup
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSMutableString *urlString = _schema.mutableCopy;
    [urlString appendString: _host];
    [urlString appendString: routerParam];
    NSURL *url = [NSURL URLWithString:urlString];

    //NSMutableRequest setup
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSError* error;
    NSDictionary *userDictionary = [[NSDictionary alloc] initWithDictionary:jsonDict];

    if ([NSJSONSerialization isValidJSONObject:userDictionary]) {
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDictionary options:0 error: &error];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:jsonData];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];

        NSLog(@"\n🚀 POST request %@", urlRequest.description);

        NSLog(@"\n⬆️ Body enviado pra POST request %@", [[NSString alloc] initWithData: urlRequest.HTTPBody encoding:NSUTF8StringEncoding]);

        //Execute Request
        [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,
                                                                            NSURLResponse *response,
                                                                            NSError *error)  {

            if (error) NSLog(@"POST Request error - %@",
                             [serviceError requestFailedWithDescription:error.localizedDescription]);
            else {
                //NSLog(@"\n⬇️ Body recebido no retorno da POST request %@", [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding]);

                NSError * serializationError;
                NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:kNilOptions
                                                                          error:&serializationError];

                NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                if (HTTPResponse.statusCode != 200 && HTTPResponse.statusCode != 201) {
                    NSLog(@"GET Response Error");
                    [self printErrorWithStatusCode:HTTPResponse.statusCode error:nil];
                }

                if (serializationError) NSLog(@"POST JSONSerialization error - %@", serializationError.localizedDescription);
                else callbackBlock(results.description);
            }
            
        }] resume ];
    }
}

-(void)putData: (NSMutableDictionary *)jsonDict : (NSString *)routerParam
    completion: (void (^)(NSString*))callbackBlock {

    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSMutableString *urlString = _schema.mutableCopy;
    [urlString appendString: _host];
    [urlString appendString: routerParam];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    NSError* error;
    NSDictionary *userDictionary = [[NSDictionary alloc] initWithDictionary:jsonDict];

    if ([NSJSONSerialization isValidJSONObject:userDictionary]) {
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDictionary options:0 error:&error];

        [urlRequest setHTTPMethod:@"PUT"];
        [urlRequest setHTTPBody:jsonData];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        NSLog(@"\n🚀 PUT request %@", urlRequest.description);

        /// Checar o body da request como string
        NSLog(@"\n⬆️ Body enviado pra PUT request %@", [[NSString alloc] initWithData: urlRequest.HTTPBody encoding:NSUTF8StringEncoding]);

        [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,
                                                                            NSURLResponse *response,
                                                                            NSError *error)  {

            if (error) NSLog(@"PUT Request error - %@",serviceError.badRequest);
            else {
                //NSLog(@"\n⬇️ Body recebido no retorno da PUT request %@", [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding]);

                NSError * serializationError;
                NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:kNilOptions
                                                                          error:&serializationError];

                NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                if (HTTPResponse.statusCode != 200) {
                    NSLog(@"GET Response Error");
                    [self printErrorWithStatusCode:HTTPResponse.statusCode error:nil];
                }

                if (serializationError) NSLog(@"PUT JSONSerialization error - %@", serializationError.localizedDescription);
                else callbackBlock(results.description);
            }

        }] resume ];
        
    }
}

-(void)deleteData: (NSString *)routerParam
       completion: (void (^)(NSString*))callbackBlock {

    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSMutableString *urlString = _schema.mutableCopy;
    [urlString appendString: _host];
    [urlString appendString: routerParam];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    [urlRequest setHTTPMethod:@"DELETE"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSLog(@"\n🚀 DELETE request %@", urlRequest.description);

    [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,
                                                                        NSURLResponse *response,
                                                                        NSError *error)  {

        //NSLog(@"\n⏺ Method DELETE successfull");

        if (error) NSLog(@"DELETE Request error - %@",serviceError.badRequest);
        else {
            //NSLog(@"\n⬇️ Body recebido no retorno da DELETE request %@", [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding]);

            NSError * serializationError;
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:kNilOptions
                                                                      error:& serializationError];

            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
            if (HTTPResponse.statusCode != 200) {
                NSLog(@"GET Response Error");
                [self printErrorWithStatusCode:HTTPResponse.statusCode error:nil];
            }

            if (serializationError) NSLog(@"DELETE JSONSerialization error - %@", serializationError.localizedDescription);
            else callbackBlock(results.description);
        }

    }] resume ];

}

-(void)requestWithMethodAndBody: (NSString *)httpMethod : (NSMutableDictionary *)jsonDict : (NSString *)routerParam
    completion: (void (^)(NSString*))callbackBlock {

    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSMutableString *urlString = _schema.mutableCopy;
    [urlString appendString: _host];
    [urlString appendString: routerParam];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    NSError* error;
    NSDictionary *userDictionary = [[NSDictionary alloc] initWithDictionary:jsonDict];

    if ([NSJSONSerialization isValidJSONObject:userDictionary]) {
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDictionary options:NSJSONWritingPrettyPrinted error:&error];

        [urlRequest setHTTPMethod:httpMethod];
        [urlRequest setHTTPBody:jsonData];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        NSLog(@"\n🚀 %@ request %@", httpMethod, urlRequest.description);

        /// Checar o body da request como string
        NSLog(@"\n⬆️ Body enviado pra %@ request %@", httpMethod, [[NSString alloc] initWithData: urlRequest.HTTPBody encoding:NSUTF8StringEncoding]);

        [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,
                                                                            NSURLResponse *response,
                                                                            NSError *error)  {

            if (error) NSLog(@"%@ Request error - %@", httpMethod, serviceError.badRequest);
            else {
                //NSLog(@"\n⬇️ Body recebido no retorno da PUT request %@", [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding]);

                NSError * serializationError;
                NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:kNilOptions
                                                                          error:&serializationError];

                NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                if (HTTPResponse.statusCode != 200 && HTTPResponse.statusCode != 201 ) {
                    NSLog(@"%@ Response Error", httpMethod);
                    [self printErrorWithStatusCode:HTTPResponse.statusCode error:nil];
                }

                if (serializationError) NSLog(@"%@ JSONSerialization error - %@",httpMethod, serializationError.localizedDescription);
                else callbackBlock(results.description);
            }

        }] resume ];
        
    }
}

-(void)requestWithMethod: (NSString *)httpMethod : (NSString *)routerParam
    completion: (void (^)(NSString*))callbackBlock {

    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSMutableString *urlString = _schema.mutableCopy;
    [urlString appendString: _host];
    [urlString appendString: routerParam];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    NSError* error;

    [urlRequest setHTTPMethod:httpMethod];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSLog(@"\n🚀 %@  request %@", httpMethod,urlRequest.description);

    [[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,
                                                                        NSURLResponse *response,
                                                                        NSError *error)  {

        if (error) NSLog(@"%@ Request error - %@",httpMethod ,serviceError.badRequest);
        else {

            NSError * serializationError;
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:kNilOptions
                                                                      error:&serializationError];

            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
            if (HTTPResponse.statusCode != 200 && HTTPResponse.statusCode != 201) {
                NSLog(@"%@ Response Error",httpMethod);
                [self printErrorWithStatusCode:HTTPResponse.statusCode error:nil];
            }

            if (serializationError) NSLog(@"%@ JSONSerialization error - %@",httpMethod ,serializationError.localizedDescription);
            else callbackBlock(results.description);
        }

    }] resume ];
}
@end
