//
//  AFNetworkingTool.h
//  Demo1_AFNetworking封装
//
//  Created by 郭正豪 on 16/1/14.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailureBlock)(NSError *error);
@interface NetworkingManager : NSObject

+ (void)getRequestWithAFNetworking:(NSURL *)url parameters:(NSDictionary *)param success:(SuccessBlock)successBlock failure:(FailureBlock)failBlock;

@end
