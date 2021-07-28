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

@property (weak, nonatomic) IBOutlet UITextView *getTextView;

@property (weak, nonatomic) IBOutlet UIButton *getButton;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UIButton *putButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
@implementation HTTPOBJCViewController

- (IBAction)getButtonAction:(UIButton *)sender {

    httpRequest * requester = [httpRequest alloc];
    requester.schema = @"https";
    requester.host = @"://jsonplaceholder.typicode.com";
    [requester fetchData: @"/posts/1"
              completion:^(NSString * result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.getTextView.text = [NSString stringWithFormat:@"CALLBACK GET\n %@",result];
        });
        [self printString: result];
    }];

}

- (IBAction)postButtonAction:(UIButton *)sender {
    httpRequest * requester = [httpRequest alloc];
    requester.schema = @"https";
    requester.host = @"://jsonplaceholder.typicode.com";
    NSMutableDictionary *uDictionary = [[NSMutableDictionary alloc] init];
    [uDictionary setValue:@"Bulbassaur" forKey:@"name"];
    [uDictionary setValue:@"fullstack" forKey:@"job"];
    [requester postData:uDictionary :@"/posts" completion:^(NSString * result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.getTextView.text = [NSString stringWithFormat:@"CALLBACK POST\n %@",result];
        });
            [self printString: result];
        }];
}

- (IBAction)putButtonAction:(UIButton *)sender {
    httpRequest * requester = [httpRequest alloc];
    requester.schema = @"https";
    requester.host = @"://jsonplaceholder.typicode.com";
    NSMutableDictionary *uDictionary = [[NSMutableDictionary alloc] init];
    [uDictionary setValue:@"Pikachu" forKey:@"name"];
    [uDictionary setValue:@"fullstack" forKey:@"job"];
    [requester putData:uDictionary :@"/users/2"
            completion:^(NSString * result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.getTextView.text = [NSString stringWithFormat:@"CALLBACK PUT\n %@",result];
        });
        [self printString: result];
    }];

}

- (IBAction)deleteButtonAction:(UIButton *)sender {
    httpRequest * requester = [httpRequest alloc];
    requester.schema = @"https";
    requester.host = @"://jsonplaceholder.typicode.com";
    [requester deleteData: @"/users/2"
               completion:^(NSString * result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.getTextView.text = [NSString stringWithFormat:@"CALLBACK DELETE\n %@",result];
        });
        [self printString: result];
    }];
}


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
//    httpRequest * requester = [httpRequest alloc];
//    NSMutableDictionary *uDictionary = [[NSMutableDictionary alloc] init];
//    [uDictionary setValue:@"Pikachu" forKey:@"name"];
//    [uDictionary setValue:@"fullstack" forKey:@"job"];
//    requester.schema = @"https";
//    requester.host = @"://jsonplaceholder.typicode.com";

//    // GET
//    [requester fetchData: @"/posts/1"
//              completion:^(NSString * result) {
//        NSLog(@"Callback GET");
//        [self printString: result];
//    }];
      // requestWithMethod
//    [requester requestWithMethod:@"POST" :@"/posts" completion:^(NSString * result) {
//        [self printString: result];
//    }];


    // requestWithMethodAndBody
//  [requester requestWithMethodAndBody:@"POST":uDictionary:@"/posts" completion:^(NSString * result) {
//      [self printString: result];
//  }];


    // POST
//    [requester postData:uDictionary :@"/posts" completion:^(NSString * result) {
//        NSLog(@"Callback POST");
//        [self printString: result];
//    }];
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

- (IBAction)postActionButton:(UIButton *)sender {
}

- (IBAction)getActionButton:(UIButton *)sender {
}
- (IBAction)deleteActionButton:(UIButton *)sender {
}

- (IBAction)putActionButton:(UIButton *)sender {
}
@end
