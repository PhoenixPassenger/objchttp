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

- (void)viewDidLoad
{
    [super viewDidLoad];
    __block BOOL flag = NO;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        httpRequest * requester = [httpRequest alloc];
        [requester fetchData:&flag];
    });
    while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && !flag){};
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
