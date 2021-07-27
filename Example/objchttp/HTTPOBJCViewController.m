//
//  HTTPOBJCViewController.m
//  objchttp
//
//  Created by 32482081 on 07/21/2021.
//  Copyright (c) 2021 32482081. All rights reserved.
//

#import "HTTPOBJCViewController.h"
#import <objchttp/httpRequest.h>
@interface HTTPOBJCViewController ()
@end

@implementation HTTPOBJCViewController

-(void)printString: (NSString *) string{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        _label.text = string;
    });
    NSLog(@"%@", string);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    httpRequest * requester = [httpRequest alloc];
        NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Fullstack", @"job", nil];
        NSDictionary *uDictionary = userDictionary.mutableCopy;
        [uDictionary setValue:@"Pikachu" forKey:@"name"];
    // GET
    [requester fetchData:@"https"
                    host:@"://jsonplaceholder.typicode.com"
             routerParam:@"/posts/1"
              completion:^(NSString * result) {
        NSLog(@"Callback GET");
        [self printString: result];
    }];

    // POST
    [requester postData:@"https"
                   host:@"://jsonplaceholder.typicode.com"
            routerParam:@"/posts/"
             completion:^(NSString * result) {
        NSLog(@"Callback POST");
        [self printString: result];
    }];

    // PUT
    [requester putData:@"https"
                  host:@"://reqres.in/api"
           routerParam:@"/users/2"
            completion:^(NSString * result) {
        NSLog(@"Callback PUT");
        [self printString: result];
    }];

    // DELETE
    [requester deleteData:@"https"
                     host:@"://reqres.in/api"
              routerParam:@"/users/2"
               completion:^(NSString * result) {
        NSLog(@"Callback DELETE");
        [self printString: result];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end