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

    NSError * error;

    [requester printaErro:600 error:&error];

    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }

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
