//
//  httpRequest.h
//  http
//
//  Created by Rodrigo Silva Ribeiro on 20/07/21.
//

#import <Foundation/Foundation.h>
@interface httpRequest : NSObject
-(void)fetchData: (void (^)(NSString*))callbackBlock;
-(void)postData: (BOOL *) flag;
@end
