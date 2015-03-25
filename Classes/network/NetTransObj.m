//
//  NetTransObj.m
//  TestForNet
//
//  Created by xiu fiona on 13-2-22.
//  Copyright (c) 2013年 xiu fiona. All rights reserved.
//

#import "NetTransObj.h"
#import "AppDelegate.h"
//#import "UserLoginViewController.h"
#import "JSONKit.h"
#import "CHKeychain.h"
#import "ASIHTTPRequest.h"


@implementation NetTransObj
@synthesize uinet,requst,nTag,nApiTag;
@synthesize getRequest;

-(id)init:(id<UINetTransDelegate>)ui nITag:(int)nITag nApi:(int)nApi
{
    self.uinet = ui;
    self.nTag = nApi;
    self.nApiTag = nApi;
    return self;
}

-(id)testErroArray:(id)text
{
    if(text == [NSNull null])
    {
        return nil;
    }
    if(![text isKindOfClass:[NSArray class]])
    {
        return nil;
    }
    
    return text;
}
-(NSString*)testErroStr:(id)text
{
    if([text isKindOfClass:[NSArray class]])
    {
        return nil;
    }
    if(text == nil)
    {
        return nil;
    }
    
    if(text == [NSNull null])
    {
        return nil;
    }
    
    if(![text isKindOfClass:[NSString class]])
    {
        return [NSString stringWithFormat:@"%@", text];
    }
    return text;
}
- (BOOL)requestFailed:(ASIHTTPRequest *)request{
//    NSLog(@"faild-------\n%@\n%@", request.url.description,[[[NSString alloc] initWithData:request.postBody encoding:    NSUTF8StringEncoding] autorelease]);
 
    NSLog(@"faild----:%ld, %d", (long)request.error.code, ASIConnectionFailureErrorType);
    
#ifdef DEBUG_SHOWLOG
    //将debug信息写入文件
    [DebugInfoFileManager saveDebugInfo:[NSString stringWithFormat:@"faild----post Value:\n%@", request.postBody]];
#endif
    
    if(request.error.code == ASIRequestTimedOutErrorType)
    {
        //[[iToast makeText:@"联网连接超时，请重试！"]show];
        return TRUE;
    }
    return TRUE;
}
-(NSString *) unicodeToUtf8:(NSString *)string
{
    NSString *tempStr1 = [string stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
                          NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
                          NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                                                 mutabilityOption:NSPropertyListImmutable
                                                                                           format:NULL
                                                                                 errorDescription:NULL];
                          
                          //NSLog(@"Output = %@", returnStr);
                          
                          return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
                          }
-(BOOL) responseSuccess:(ASIHTTPRequest *)request{
    
    if([request didUseCachedResponse]){
        NSLog(@"=========资源请求：%@ 来自缓存============",[request url]);
        
    }else{
        NSLog(@"=========资源请求：%@ 不来自缓存============",[request url]);
    }
    
    NSString *poststr = [NSString stringWithFormat:@"success-------%@\npost:%@", request.url.description,[[NSString alloc] initWithData:request.postBody encoding:NSUTF8StringEncoding]];
#ifdef DEBUG_SHOWLOG
    //将debug信息写入文件
    [DebugInfoFileManager saveDebugInfo:[NSString stringWithFormat:@"\n%@", poststr]];
#endif
//    NSArray *cookies = [request responseCookies];
//    NSLog ( @"session name:%@" ,cookies);
//    /*保存cookie信息*/
//    for (NSHTTPCookie *cookie in cookies) {
//        if ([[cookie name ] isEqualToString : @"ms_ci_sessions" ]) {
//            [CHKeychain save:K_USER_COOKIE_VALUE data:cookie];
//        }
//    }
    /* 设置user agent 用来避免webview请求导致的api接口需要重新登录 start */
//    NSString *useragentstr = [ASIHTTPRequest defaultUserAgentString];
//    NSLog(@"useragentstr=%@",useragentstr);
//
//    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:USER_LOGIN_USER_ID];
//    NSString *userkey = [[NSUserDefaults standardUserDefaults] objectForKey:USER_LOGIN_USER_key];
//    
//    NSString *useragent = [NSString stringWithFormat:@"%@||userid=%@;user_skey=%@",useragentstr,userid,userkey];
//    
//    NSDictionary *dictionary = [NSDictionary
//                                dictionaryWithObjectsAndKeys:
//                                useragent,
//                                @"UserAgent", nil];
//    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    /* 设置user agent 用来避免webview请求导致的api接口需要重新登录 end */
    //NSString *struseragent = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserAgent"];
    
    NSData * myResponseData = [request responseData];
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);//kCFStringEncodingUTF8
	NSString * myResponseStr = [[NSString alloc] initWithData:myResponseData encoding:enc];
    NSLog(@"%@ success-------\n%@\npost:%@",self.uinet,  request.url.description,[[NSString alloc] initWithData:request.postBody encoding:    NSUTF8StringEncoding]);
    NSDictionary  *jsonDic = [myResponseStr objectFromJSONString];
    if (jsonDic == nil) {
        NSLog(@"页面错误：%@", myResponseStr);
#ifdef DEBUG_SHOWLOG
        //将debug信息写入文件
        [DebugInfoFileManager saveDebugInfo:[NSString stringWithFormat:@"\n页面错误：%@", myResponseStr]];
#endif
        [uinet requestFailed:self.nTag withStatus:WEB_STATUS_0 withMessage:@"页面错误！"];
        [[NetTrans getInstance]removeNetObj:self];
        return NO;
    }
    NSLog(@"jsonDic:%@", jsonDic);
    NSLog(@"json:%@", [self unicodeToUtf8:jsonDic.description]);

#ifdef DEBUG_SHOWLOG
    //将debug信息写入文件
    [DebugInfoFileManager saveDebugInfo:[NSString stringWithFormat:@"\njson:%@", [self unicodeToUtf8:jsonDic.description]]];
#endif
//    NSString *status = [NSString stringWithFormat:@"%@",[jsonDic objectForKey:@"status"]];
//    NSString *message = [jsonDic objectForKey:@"message"];
    NSArray *errMsg ;

        //1. parse xml
    NSMutableArray *arrRtn = nil;
    NSInteger total;
    BOOL isSuccess = YES;
    if ([jsonDic valueForKey:@"total"]) {
        NSInteger t = [[(NSString *)jsonDic valueForKey:@"total"] integerValue];
        total = t;
    }
    NSString* strStatus = @"";
    NSString* strErr = @"";
    /*       failed   status=0      */
    if ([jsonDic valueForKey:@"status"] && [[jsonDic valueForKey:@"status"] integerValue] == 0) {
        //返回错误，状态为0
        if ([jsonDic valueForKey:@"message"]) {
            strStatus = @"0";
            strErr = [jsonDic valueForKey:@"message"];
            arrRtn = nil;
            errMsg = [NSArray arrayWithObjects:@"0",[jsonDic valueForKey:@"message"], nil];
        }else
        {
            strStatus = @"0";
            strErr = [jsonDic valueForKey:@"info"];
            arrRtn = nil;
            errMsg = [NSArray arrayWithObjects:@"0",[jsonDic valueForKey:@"info"], nil];
        }
        isSuccess = NO;
    }else if ([jsonDic valueForKey:@"status"] && [[jsonDic valueForKey:@"status"] integerValue] == 10000) {
        //返回状态为10000，用户未登陆。
        
        [SecurityMethod G_set_isLogin:NO];
        
        if ([jsonDic valueForKey:@"message"]) {
            strStatus = @"10000";
            strErr = [jsonDic valueForKey:@"message"];
            
            arrRtn = nil;
            errMsg = [NSArray arrayWithObjects:@"10000",[jsonDic valueForKey:@"message"], nil];
        }
        isSuccess = NO;
    }
    else if ([jsonDic valueForKey:@"status"] && [[jsonDic valueForKey:@"status"] integerValue] == 10100) {
        //返回状态为10000，用户未登陆。
        
        
        
        if ([jsonDic valueForKey:@"message"]) {
            strStatus = @"10100";
            strErr = [jsonDic valueForKey:@"message"];
            
            arrRtn = nil;
            errMsg = [NSArray arrayWithObjects:@"10100",[jsonDic valueForKey:@"message"], nil];
        }
        isSuccess = NO;
    }
    else if ([jsonDic valueForKey:@"status"] == nil) {
        strStatus = @"status 为空";

        strErr = [jsonDic valueForKey:@"message"];
        //返回错误信息，网络返回页面错误。
        errMsg = [NSArray arrayWithObjects:@"status 为空",[jsonDic valueForKey:@"message"], nil];
        arrRtn = nil;
        isSuccess = NO;
    }
    if(!isSuccess)
    {
        if (self.nTag == t_API_SHAKE && [strStatus integerValue] == 0) {
             return YES;
        }
        [uinet requestFailed:self.nTag withStatus:strStatus withMessage:strErr ];
        [[NetTrans getInstance]removeNetObj:self];
        return NO;
    }
    /* 失败或需要登陆 */
//    if ([status isEqualToString:WEB_STATUS_10000]) {
//        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//        BOOL isAutoLogin = [userDefaults boolForKey:D_AUTOLOGIN];
//        NSDictionary *dic = [CHKeychain load:D_USERSECURITYINFO];
//        NSLog(@"自动登陆：%d", isAutoLogin);
//        [iConsole log:[NSString stringWithFormat:@"%s --自动登陆：%d", __func__, isAutoLogin]];
//        if (isAutoLogin == YES) {
//            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//
//            [[NetTrans getInstance] Employee_Login:appdelegate
//                                          UserName:[dic valueForKey:KEY_USER_NAME]
//                                          Password:[dic valueForKey:KEY_USER_PASSWORD]];
//            
//        }else{
//
//        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        UserLoginViewController *loginv = [[UserLoginViewController alloc]init];
//        [appdelegate.tabBarController presentModalViewController:loginv animated:YES];
//        [loginv release];
//        }
//        [[NetTrans getInstance]removeNetObj:self];
//  
//        return NO;
//        
//    }
//    if([status isEqualToString:WEB_STATUS_0])
//    {
//        [uinet requestFailed:self.nTag withStatus:status withMessage:message];
//        [[NetTrans getInstance]removeNetObj:self];
//        return NO;
//    }
    return YES;
}

@end
