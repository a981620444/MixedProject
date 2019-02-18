//
//  HttpTool.m
//  MixedDemo
//
//  Created by simple on 2019/1/27.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

@implementation HttpTool


static AFHTTPSessionManager *manager = nil;
+(AFHTTPSessionManager *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/javascript",@"text/html", @"text/plain", @"text/json", nil];
    });
    return manager;
}

+(void)getReachabilityStatus:(void(^)(NSString *state))comple{
   // AFNetworkReachabilityStatus status;
    AFNetworkReachabilityManager *ReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [ReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *state = @"";
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                state = @"未知网络状态";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                state = @"无网络";
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                state = @"蜂窝数据网";
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                state = @"WiFi网络";
                break;
                
            default:
                break;
        }
        comple(state);
    }];
    [ReachabilityManager startMonitoring];
}

+(void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:( void (^)(id responseObject))success{
    
    [[HttpTool sharedManager]GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (success) {
            success(nil);
        }
    }];
    
}

@end
