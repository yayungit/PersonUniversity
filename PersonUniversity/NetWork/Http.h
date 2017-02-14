//
//  Http.h
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/10.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


@interface Http : NSObject
+(void)sharedInstance;

-(NSURLSessionDataTask *)sessionReuestForURL:(NSString *)url withParams:(NSDictionary *)params completion:(void(^)(id , NSError *)) completion;

@end
