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
    Class responeObject = [self class];
    // 实例化
    id instantiateObject = [[responeObject alloc] init];
    if (dictionary.count <= 0) {
        return instantiateObject;
    }
    
    // 获取model类型中的 属性
    
    
    
    
    return instantiateObject;
}
//+ (NSArray *)objectKeysValuesWithArray:(NSArray *)array {
//    
//}


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
