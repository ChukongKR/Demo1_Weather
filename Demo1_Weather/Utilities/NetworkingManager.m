//
//  AFNetworkingTool.m
//  Demo1_AFNetworking封装
//
//  Created by 郭正豪 on 16/1/14.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "NetworkingManager.h"

@implementation NetworkingManager

+ (void)getRequestWithAFNetworking:(NSURL *)url parameters:(NSDictionary *)param success:(SuccessBlock)successBlock failure:(FailureBlock)failBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url.absoluteString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}

@end
