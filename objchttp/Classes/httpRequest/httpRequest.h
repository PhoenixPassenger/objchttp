//
//  httpRequest.h
//  http
//
//  Created by Rodrigo Silva Ribeiro on 20/07/21.
//

#import <Foundation/Foundation.h>
@interface httpRequest : NSObject
-(void)fetchData: (void (^)(NSString*))callbackBlock;
-(void)postData: (void (^)(NSString*))callbackBlock;
-(void)putData: (void (^)(NSString*))callbackBlock;
-(void)deleteData: (void (^)(NSString*))callbackBlock;
@end
