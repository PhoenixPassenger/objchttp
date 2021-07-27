//
//  httpRequest.h
//  http
//
//  Created by Rodrigo Silva Ribeiro on 20/07/21.
//

#import <Foundation/Foundation.h>
@interface httpRequest : NSObject

-(void)fetchData:(NSString *)schema host: (NSString *)host routerParam: (NSString *)routerParam completion: (void (^)(NSString*))callbackBlock;
-(void)postData: (NSString *)schema host: (NSString *)host routerParam: (NSString *)routerParam completion: (void (^)(NSString*))callbackBlock;
-(void)putData: (NSString *)schema host: (NSString *)host routerParam: (NSString *)routerParam completion: (void (^)(NSString*))callbackBlock;
-(void)deleteData: (NSString *)schema host: (NSString *)host routerParam: (NSString *)routerParam completion: (void (^)(NSString*))callbackBlock;

- (void)printaErro:(int)code error:(NSError**)error;

@end
