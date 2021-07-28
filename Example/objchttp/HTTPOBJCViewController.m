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
    NSMutableDictionary *uDictionary = [[NSMutableDictionary alloc] init];
    [uDictionary setValue:@"Pikachu" forKey:@"name"];
    [uDictionary setValue:@"fullstack" forKey:@"job"];
    requester.schema = @"https";
    requester.host = @"://jsonplaceholder.typicode.com";

//    // GET
//    [requester fetchData: @"/posts/1"
//              completion:^(NSString * result) {
//        NSLog(@"Callback GET");
//        [self printString: result];
//    }];

    // POST
    [requester postData:uDictionary :@"/posts" completion:^(NSString * result) {
        NSLog(@"Callback POST");
        [self printString: result];
    }];
//    // PUT
//    [requester putData:uDictionary :@"/users/2"
//            completion:^(NSString * result) {
//        NSLog(@"Callback PUT");
//        [self printString: result];
//    }];
//
////     DELETE
//    [requester deleteData: @"/users/2"
//               completion:^(NSString * result) {
//        NSLog(@"Callback DELETE");
//        [self printString: result];
//    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
