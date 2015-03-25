//
//  AESEncode.h
//  SingleViewSwift
//
//  Created by efuture on 15/1/19.
//  Copyright (c) 2015年 efuture. All rights reserved.
//

#import <Foundation/Foundation.h>

//aes加解密
@class NSString;

@interface NSData (AESEncode)

- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密
- (NSString *)newStringInBase64FromData;            //追加64编码
+ (NSString*)base64encode:(NSString*)str;           //同上64编码

@end
