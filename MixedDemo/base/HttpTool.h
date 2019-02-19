//
//  HttpTool.h
//  MixedDemo
//
//  Created by simple on 2019/1/27.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPSessionManager;

@interface HttpTool : NSObject

+(AFHTTPSessionManager *)sharedManager;

+(void)getReachabilityStatus:(void(^)(NSString *state))comple;

+(void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:( void (^)(id responseObject))success;

@end
