//
//  NSObject+Reflect.m
//  THEmployee
//
//  Created by Liuzhichao  on 13-9-4.
//  Copyright (c) 2013年 TianHong. All rights reserved.
//

#import "NSObject+Reflect.h"

@implementation NSObject (Reflect)
- (NSArray*)propertyKeys
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableArray *keys = [[[NSMutableArray alloc] initWithCapacity:outCount] autorelease];
    
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [[[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding]autorelease];
        [keys addObject:propertyName];
    }
    
    free(properties);
    return keys;
}

- (BOOL)reflectDataFromOtherObject:(NSObject*)dataSource
{
    BOOL ret = NO;
    for (NSString *key in [self propertyKeys])
    {
        if ([dataSource isKindOfClass:[NSDictionary class]])
        {
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
        }
        
        else
        {
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
        }
        
        if (ret)
        {
            id propertyValue = [dataSource valueForKey:key];
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSArray class]]) {
                propertyValue = [NSString stringWithFormat:@"%@",[dataSource valueForKey:key]];
            }
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil)
            {
                [self setValue:propertyValue forKey:key];
            }
        }
    }
    return ret;
}

//利用反射取得NSObject的属性，并存入到数组中
- (NSArray *)getPropertyList: (Class)clazz{
    u_int count;
    objc_property_t *properties = class_copyPropertyList(clazz, &count);
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties); 
    return propertyArray;
}

//把一个实体对象，封装成字典Dictionary
- (NSDictionary *)convertDictionary
{
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
    NSArray *propertyList =[self propertyKeys];
    for (NSString *key in propertyList) {
        SEL selector = NSSelectorFromString(key);
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id value = [self performSelector:selector];
#pragma clang diagnostic pop
        
        if (value == nil) {
            value = [NSNull null];
        }
        [dict setObject:value forKey:key];
    }
    return dict;
}
@end
