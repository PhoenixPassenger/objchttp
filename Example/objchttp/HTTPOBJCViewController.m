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

@property httpRequest * requester;
@property NSMutableDictionary *uDictionary;

@property (weak, nonatomic) IBOutlet UITextView *getTextView;

@property (weak, nonatomic) IBOutlet UIButton *getButton;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UIButton *putButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
@implementation HTTPOBJCViewController

// MARK: - GET REQUEST
- (IBAction)getButtonAction:(UIButton *)sender {
    [self.requester fetchData: @"/posts/1"
              completion:^(NSString * result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.getTextView.text = [NSString stringWithFormat:@"CALLBACK GET\n %@",result];
        });
        [self printString: result];
    }];

}

// MARK: - POST REQUEST
- (IBAction)postButtonAction:(UIButton *)sender {

    NSMutableDictionary *uDictionary = [[NSMutableDictionary alloc] init];
    [uDictionary setValue:@"Pikachu" forKey:@"name"];
    [uDictionary setValue:@"fullstack" forKey:@"job"];

    [self.requester postData:uDictionary :@"/posts" completion:^(NSString * result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.getTextView.text = [NSString stringWithFormat:@"CALLBACK POST\n %@",result];
        });
            [self printString: result];
        }];
}

// MARK: - PUT REQUEST
- (IBAction)putButtonAction:(UIButton *)sender {

    NSMutableDictionary *uDictionary = [[NSMutableDictionary alloc] init];
    [uDictionary setValue:@"Bulbassaur" forKey:@"name"];
    [uDictionary setValue:@"fullstack" forKey:@"job"];

    [self.requester putData:uDictionary :@"/users/2"
            completion:^(NSString * result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.getTextView.text = [NSString stringWithFormat:@"CALLBACK PUT\n %@",result];
        });
        [self printString: result];
    }];

}

// MARK: - DELETE REQUEST
- (IBAction)deleteButtonAction:(UIButton *)sender {
    [self.self.requester deleteData: @"/users/2"
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
    self.requester = [httpRequest alloc];
    self.requester.schema = @"https";
    self.requester.host = @"://jsonplaceholder.typicode.com";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
