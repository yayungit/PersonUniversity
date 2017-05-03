//
//  NSObject+YYSkyModel.m
//  PersonUniversity
//
//  Created by YYSky-Star on 2017/4/14.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "NSObject+YYSkyModel.h"
#import <objc/runtime.h>

@implementation NSObject (YYSkyModel)


+ (id<JSONEntityElementProtocol>)objectKeysValuesWithDictionary:(NSDictionary *)dictionary {
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    // 响应对象
    Class responeCls = [self class];
    // 实例化
    id responeObject = [[responeCls alloc] init];
    if (dictionary.count <= 0) {
        return responeObject;
    }
    // 获取model类型中的 属性
    [responeObject getPropertyNameWithClass:responeObject withBoclk:^(NSString *propertyName, NSString *propertyType) {
        
        __block id propertyValue = dictionary[propertyName];
        
        if ([propertyValue isKindOfClass:[NSDictionary class]]) {
            
            id propertyObject = nil;
            NSString *propertyClassName = nil;
            // 如果有替换方法的实现
            if ([self respondsToSelector:@selector(replacedEntityElementDictionary)]) {
                NSDictionary *dic = [self performSelector:@selector(replacedEntityElementDictionary)];
                propertyClassName = dic[propertyName];
            }
            propertyClassName = propertyClassName ? :propertyType;
            //
            if (propertyClassName) {
                // 第二model
                Class cls = NSClassFromString(propertyClassName);
                // 如果直接字典
                if ([cls isSubclassOfClass:[NSDictionary class]]) {
                    propertyObject = propertyValue;
                } else {
                    // 如果嵌套字典，转换了另外一个model
                    propertyObject = cls ? [cls objectKeysValuesWithDictionary:propertyValue] : propertyValue;
                }
            } else {
                // 非转换为第二model
                Class cls = NSClassFromString(propertyName);
                propertyObject = cls ? [cls objectKeysValuesWithDictionary:propertyValue] : propertyValue;
            }
            if (propertyObject) {
                [responeObject setValue:propertyObject forKey:propertyName];
            }
            
        } else if ([propertyValue isKindOfClass:[NSArray class]]) {
            NSString *propertyClassName = nil;
            // 发生替换
            if ([self respondsToSelector:@selector(replacedEntityElementDictionary)]) {
                NSDictionary *dic = [self performSelector:@selector(replacedEntityElementDictionary)];
                propertyClassName = dic[propertyName];
            }
            
            propertyClassName = propertyClassName ? : propertyName;
            
            Class cls = NSClassFromString(propertyClassName);
            id propertyObj = cls ? [cls objectKeysValuesWithArray:propertyValue] : propertyValue;
            if (propertyObj) {
                [responeObject setValue:propertyObj forKey:propertyName];
            }
            
        } else {
            // 替换特殊字典 id之类
            if ([self respondsToSelector:@selector(replacedEntityElementDictionary)]) {
                NSDictionary *dic = [self performSelector:@selector(replacedEntityElementDictionary)];
                if ([[dic allKeys] containsObject:propertyName]) {
                    [dic enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSString   * obj, BOOL * _Nonnull stop) {
                        if ([propertyName isEqualToString:key]) {
                            propertyValue = dic[obj];
                        }
                    }];
                }
            }
            if (propertyValue) {
                [responeObject setValue:[NSString stringWithFormat:@"%@", propertyValue] forKey:propertyName];
            }
        }
    }];
    
    
    
    
    return responeObject;
}
+ (NSArray *)objectKeysValuesWithArray:(NSArray *)array {
    NSMutableArray *propertyArray = [NSMutableArray array];
    for (id obj in array) {
        id propertyValue = nil;
        if ([obj isKindOfClass:[NSDictionary class]]) {
           propertyValue =  [self objectKeysValuesWithDictionary:obj];
        } else if([obj isKindOfClass:[NSArray class]]) {
            propertyValue = [self objectKeysValuesWithArray:obj];
        } else {
            propertyValue = obj;
        }
        if (obj) {
            [propertyArray addObject:propertyValue];
        }
    }
    return propertyArray;
}


// 获取属性列表
+ (NSArray *)getPropertyNameWithClass:(Class)cls withBoclk:(void(^)(NSString *propertyName, NSString *propertyType))block {
//    Class clss = [self class];
    NSMutableArray *propertyArray = [NSMutableArray new];
    // 获取实例对象
    unsigned count ;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    for (int i = 0; i < count ;i++) {
        objc_property_t property = properties[i];
        const char *propertyNameAtt = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:propertyNameAtt encoding:NSUTF8StringEncoding];
        [propertyArray addObject:propertyName];
        
        NSString *propertyType = nil;
        char *propertyAttributeValue = property_copyAttributeValue(property, "T");
        if ((propertyAttributeValue != NULL) && (propertyAttributeValue[0] == '@') && (strlen(propertyAttributeValue) >= 3)) {
            propertyType = [NSString stringWithCString:strndup(propertyAttributeValue+2, strlen(propertyAttributeValue)-3) encoding:NSUTF8StringEncoding];
        }
        if (block) {
            block(propertyName,propertyType);
        }
    }
    //        cls = [cls superclass];
    free(properties);
    return propertyArray;
}


@end
