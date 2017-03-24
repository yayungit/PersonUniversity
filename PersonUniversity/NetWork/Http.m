//
//  Http.m
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/10.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "Http.h"

@implementation Http
+(void)sharedInstance {
    static Http *http = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        http = [[Http alloc] init];
    });
}

- (void)originData {
    
//    NSURLRequestCachePolicy指定缓存逻辑。URL加载系统提供了一个磁盘和内存混合的缓存，来相应网络请求。这个缓存允许一个应用减少对网络连接的依赖，并且增加性能。使用缓存的目的是为了使用的应用程序能更快速的响应用户输入，是程序高效的运行。有时候我们需要将远程web服务器获取的数据缓存起来，减少对同一个url多次请求。
//    
//    　　NSURLRequestUseProtocolCachePolicy = 0, 默认缓存策略。具体工作：如果一个NSCachedURLResponse对于请求并不存在，数据将会从源端获取。如果请求拥有一个缓存的响应，那么URL加载系统会检查这个响应来决定，如果它指定内容必须重新生效的话。假如内容必须重新生效，将建立一个连向源端的连接来查看内容是否发生变化。假如内容没有变化，那么响应就从本地缓存返回数据。如果内容变化了，那么数据将从源端获取
//    　　NSURLRequestReloadIgnoringLocalCacheData = 1, URL应该加载源端数据，不使用本地缓存数据
//    　　NSURLRequestReloadIgnoringLocalAndRemoteCacheData =4, 本地缓存数据、代理和其他中介都要忽视他们的缓存，直接加载源数据
//    　　NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData, 两个的设置相同
//    　　NSURLRequestReturnCacheDataElseLoad = 2, 指定已存的缓存数据应该用来响应请求，不管它的生命时长和过期时间。如果在缓存中没有已存数据来响应请求的话，数据从源端加载。
//    　　NSURLRequestReturnCacheDataDontLoad = 3, 指定已存的缓存数据用来满足请求，不管生命时长和过期时间。如果在缓存中没有已存数据来响应URL加载请求的话，不去尝试从源段加载数据，此时认为加载请求失败。这个常量指定了一个类似于离线模式的行为
//    　　NSURLRequestReloadRevalidatingCacheData = 5 指定如果已存的缓存数据被提供它的源段确认为有效则允许使用缓存数据响应请求，否则从源段加载数据。
//    　　只有响应http和https的请求会被缓存。ftp和文件协议当被缓存策略允许的时候尝试接入源段。自定义的NSURLProtocol类能够保护缓存，如果它们被选择使用的话。
//    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://baidu.com"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
//    request.HTTPMethod = @"POST";
//    NSString *bodyStr = @"https://sdfdfc.com";
//    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
//    request.HTTPBody = bodyData;
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSJSONReadingMutableContainers = (1UL << 0),  返回返可变容器 例如：NSMutableDictionary或NSMutableArray
//        NSJSONReadingMutableLeaves = (1UL << 1), 返回不可变
//        NSJSONReadingAllowFragments = (1UL << 2)   允许JSON字符串最外层既不是NSArray也不是NSDictionary，但必须是有效的JSON Fragment。例如使用这个选项可以解析 @“123” 这样的字符串
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    }];
    [task resume];
}


-(NSURLSessionDataTask *)sessionReuestForURL:(NSString *)url withParams:(NSDictionary *)params completion:(void (^)(id, NSError *))completion {
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.removesKeysWithNullValues = YES;//去除为null的键值对
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    manger.responseSerializer = serializer;
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
//    NSString *currentVersion = info[@"CFBundleShortVersionString"];
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
//    [dictM setObject:@"iOS" forKey:@"client_type"];
//    [dictM setObject:currentVersion forKey:@"version_name"];
    
    
    [dictM addEntriesFromDictionary:params];
#ifdef DEBUG
    // 打印HTTP请求的URL
    [self printRequestUrl:url params:dictM];
#endif
    NSURLSessionDataTask *currentDataTask;
    if ([dictM.allKeys containsObject:@"method"] && [[dictM[@"method"] uppercaseString] isEqualToString:@"POST"]) {
        
//        currentDataTask = [manger POST:url parameters:dictM success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [self requestSuccessForTask:task responseObject:responseObject completion:completion];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            [self requestFailureForTask:task error:error completion:completion];
//        }];
        [manger POST:url parameters:dictM progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self requestSuccessForTask:task responseObject:responseObject completion:completion];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self requestFailureForTask:task error:error completion:completion];
        }];
    } else {
//        currentDataTask = [manger GET:url parameters:dictM success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [self requestSuccessForTask:task responseObject:responseObject completion:completion];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            [self requestFailureForTask:task error:error completion:completion];
//        }];
        currentDataTask = [manger GET:url parameters:dictM progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self requestSuccessForTask:task responseObject:responseObject completion:completion];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self requestFailureForTask:task error:error completion:completion];
        }];
    }
    return currentDataTask;

}

#pragma mark - Other

/** 网络请求 - 成功 */
- (void)requestSuccessForTask:(NSURLSessionDataTask * _Nullable)task responseObject:(id  _Nullable)responseObject completion:(void (^)(id, NSError *)) completion {
    
    if ([responseObject[@"code"] intValue] == 80001) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenInvalid" object:nil];
        return;
    } else if ([responseObject[@"code"] intValue] == 8000101) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"merchantTokenInvalid" object:nil userInfo:responseObject];
        return;
    }
    
    completion(responseObject, nil);
}
/** 网络请求 - 失败 */
- (void)requestFailureForTask:(NSURLSessionDataTask * _Nullable)task error:(NSError *)error completion:(void (^)(id, NSError *)) completion {
    completion(nil, error);
}
#pragma mark - Util

/**
 *  打印HTTP请求的URL
 *
 *  @param urlString URL字符串
 *  @param params    参数字典
 */
- (void)printRequestUrl:(NSString *)urlString params:(NSDictionary *)params {
    NSMutableString *totalUrl = [NSMutableString stringWithFormat:@"%@?", urlString];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj) {
            [totalUrl appendString:[NSString stringWithFormat:@"&%@=%@", key, obj]];
        }
    }];
    NSLog(@"%@请求 = %@", [params.allKeys containsObject:@"method"] && [[params[@"method"] uppercaseString] isEqualToString:@"POST"] ? @"POST" : @"GET", totalUrl);
}

// 1.调用resolveInstanceMethod给个机会让类添加这个实现这个函数
// 2.调用forwardingTargetForSelector让别的对象去执行这个函数
// 3.调用forwardInvocation（函数执行器）灵活的将目标函数以其他形式执行。
// 如果都不中，调用doesNotRecognizeSelector抛出异常。
//+(BOOL)resolveClassMethod:(SEL)sel {
//
//}
//+(BOOL)resolveInstanceMethod:(SEL)sel {
//    
//}
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//
//}
//-(void)forwardInvocation:(NSInvocation *)anInvocation {
//
//}
//-(void)doesNotRecognizeSelector:(SEL)aSelector {
//
//}

@end
