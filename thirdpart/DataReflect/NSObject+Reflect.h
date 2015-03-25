//
//  NSObject+Reflect.h
//  THEmployee
//
//  Created by Liuzhichao  on 13-9-4.
//  Copyright (c) 2013年 TianHong. All rights reserved.
//
//  解析json数据时，用反射原理解析


#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSObject (Reflect)
- (NSArray*)propertyKeys;
- (BOOL)reflectDataFromOtherObject:(NSObject*)dataSource;
- (NSArray *)getPropertyList: (Class)clazz;
- (NSDictionary *)convertDictionary;
@end
