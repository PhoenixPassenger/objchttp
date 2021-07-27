//
//  httpRequest.h
//  http
//
//  Created by Rodrigo Silva Ribeiro on 20/07/21.
//

#import <Foundation/Foundation.h>
@interface httpRequest : NSObject

@property (nonatomic, strong) NSString *schema;
@property (nonatomic, strong) NSString *host;

-(void)fetchData: (NSString *)routerParam completion: (void (^)(NSString*))callbackBlock;
-(void)postData: (NSMutableDictionary *)jsonDict : (NSString *)routerParam completion: (void (^)(NSString*))callbackBlock;
-(void)putData: (NSMutableDictionary *)jsonDict :(NSString *)routerParam completion: (void (^)(NSString*))callbackBlock;
-(void)deleteData: (NSString *)routerParam completion: (void (^)(NSString*))callbackBlock;
-(void)requestWithMethodAndBody: (NSString *)httpMethod : (NSMutableDictionary *)jsonDict :(NSString *)routerParam completion: (void (^)(NSString*))callbackBlock;
-(void)requestWithMethod: (NSString *)httpMethod : (NSMutableDictionary *)jsonDict :(NSString *)routerParam completion: (void (^)(NSString*))callbackBlock;

- (void)printErrorWithStatusCode:(long)code error:(NSError**)error;

@end
