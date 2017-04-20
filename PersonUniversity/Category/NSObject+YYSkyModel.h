//
//  NSObject+YYSkyModel.h
//  PersonUniversity
//
//  Created by YYSky-Star on 2017/4/14.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONEntityElementProtocol <NSObject>
/**
 替换系统 关键字名字及 实体类嵌套
 key: 属性名字
 value: 字典中取值时用的key
 */
+ (void)replacedEntityElementDictionary;

@end


@interface NSObject (YYSkyModel)<JSONEntityElementProtocol>

+ (id<JSONEntityElementProtocol>)objectKeysValuesWithDictionary:(NSDictionary *)dictionary;
+ (id<JSONEntityElementProtocol>)objectKeysValuesWithArray:(NSArray *)array;
+ (NSArray *)getPropertyNameWithClass:(Class)cls withBoclk:(void(^)(NSString *propertyName, NSString *propertyType))block;

@end
