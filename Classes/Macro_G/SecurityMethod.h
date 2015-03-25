//
//  SecurityMethod.h
//  myappone
//
//  Created by wbw on 12-10-26.
//  Copyright (c) 2012年 ChangShengTianDi std. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityMethod : NSObject
+(void)G_set_isLogin:(BOOL)islogin;
+(BOOL)G_is_login;
+(BOOL)G_remember_password;
+(void)G_set_remember_password:(BOOL)is_rem;
@end
