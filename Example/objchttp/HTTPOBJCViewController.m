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
    NSLog(string);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        httpRequest * requester = [httpRequest alloc];
        requester.schema = @"https";
        requester.host = @"://jsonplaceholder.typicode.com/posts/1";
        NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Fullstack", @"job", nil];
        NSDictionary *uDictionary = userDictionary.mutableCopy;
        [uDictionary setValue:@"Pikachu" forKey:@"name"];
        NSLog(uDictionary.description);
        NSLog(userDictionary.description);
        [requester fetchData:^(NSString * result) {
            [self printString: result];
        }];

//    // GET
//    [requester fetchData:^(NSString * result) {
//        [self printString: result];
//    }];
//
//    // POST
//    [requester postData:^(NSString * result) {
//        [self printString: result];
//    }];
//
//    // PUT
//    [requester putData:^(NSString * result) {
//        [self printString: result];
//    }];
//
//    // DELETE
//    [requester deleteData:^(NSString * result) {
//        [self printString: result];
//    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
