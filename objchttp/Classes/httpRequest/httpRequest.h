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
-(void)fetchData: (void (^)(NSString*))callbackBlock;
-(void)postData: (void (^)(NSString*))callbackBlock;
-(void)putData: (void (^)(NSString*))callbackBlock;
-(void)deleteData: (void (^)(NSString*))callbackBlock;

- (void)printaErro:(int)code error:(NSError**)error;

@end
