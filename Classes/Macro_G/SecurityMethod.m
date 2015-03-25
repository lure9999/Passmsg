//
//  SecurityMethod.m
//  myappone
//
//  Created by wbw on 12-10-26.
//  Copyright (c) 2012年 ChangShengTianDi std. All rights reserved.
//

#import "SecurityMethod.h"  							
extern BOOL Globe_isLogin;
extern BOOL isRememberPassword;

@implementation SecurityMethod
+(void)G_set_isLogin:(BOOL)islogin
{
    Globe_isLogin = islogin;
}
+(BOOL)G_is_login
{
 
    return Globe_isLogin;
}
+(BOOL)G_remember_password
{
    if(isRememberPassword){
        return YES;
    }else{
        return NO;
    }
}
+(void)G_set_remember_password:(BOOL)is_rem
{
    isRememberPassword = is_rem;
}
@end
