//
//  NetTrans.m
//  TestForNet
//
//  Created by xiu fiona on 13-2-21.
//  Copyright (c) 2013年 xiu fiona. All rights reserved.
//

#import "NetTrans.h"
#import "NetTransObj.h"
#import "Reachability.h"
#import "MessageEntity.h"

static NetTrans* trans = nil;

@implementation NetTrans
@synthesize arrReq,arrTongJiKey;

+(NetTrans*)getInstance
{
    if(trans == nil)
    {
        trans = [NetTrans alloc];
        [trans initData];
    }
    
    return trans;
}

-(void)initData
{
   
    self.arrReq = [NSMutableArray array];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"TongJi" ofType:@"plist"];
    arrTongJiKey  = [[NSMutableArray alloc]  initWithContentsOfFile : plistPath];
   
}
-(ASIHTTPRequest *)get:(NSString *)strUrl
{
    //NSLog(@"#######%@",[ASIHTTPRequest defaultUserAgentString]);
    NetworkStatus networkStatus = [Reachability reachabilityForInternetConnection].currentReachabilityStatus;
    if (networkStatus == NotReachable) {
//        [[iToast makeText:@"您现在没有网络！"] show];
    }

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strUrl]];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    request.timeOutSeconds = 30;
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setDidFinishSelector:@selector(responseSuccess:)];
    [request setRequestMethod:@"GET"];
    [request setUseCookiePersistence:YES];
    
//    if([[[[request url] scheme] lowercaseString] isEqualToString:@"https"]){
//        NSString *thePath = [[NSBundle mainBundle]
//                             pathForResource:HTTPSCERNAME ofType:@"cer"];
//        NSData *certData = [[NSData alloc]
//                            initWithContentsOfFile:thePath];
//        CFDataRef myCertData = (__bridge CFDataRef)certData;                 // 1
//        
//        SecCertificateRef myCert;
//        myCert = SecCertificateCreateWithData(NULL, myCertData);    // 2
//        [request setCaCertificate:myCert];
//        [request setValidatesSecureCertificate:YES];
//    }
//    else
//    {
        [request setValidatesSecureCertificate:NO];
    //}
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    return request;
}
-(ASIFormDataRequest *)post:(NSString*)strUrl
{
    //NSLog(@"#######%@",[ASIHTTPRequest defaultUserAgentString]);
    
    NetworkStatus networkStatus = [Reachability reachabilityForInternetConnection].currentReachabilityStatus;
    if (networkStatus == NotReachable) {
        [[iToast makeText:@"网络不给力，请稍后重试！"]show];
        return nil;
    }

//    NSLog(@"-- Request Post:%@",strUrl);
    //strUrl = @"https://www.tt.com";
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strUrl]];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    request.timeOutSeconds = 30;
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setDidFinishSelector:@selector(responseSuccess:)];
    [request setRequestMethod:@"POST"];
    [request setPostFormat:ASIURLEncodedPostFormat];
    [request setUseCookiePersistence:YES];
    
//    if([[[[request url] scheme] lowercaseString] isEqualToString:@"https"]){
//        NSString *thePath = [[NSBundle mainBundle]
//                         pathForResource:HTTPSCERNAME ofType:@"cer"];
//        NSData *certData = [[NSData alloc]
//                        initWithContentsOfFile:thePath];
//        CFDataRef myCertData = (__bridge CFDataRef)certData;                 // 1
//    
//        SecCertificateRef myCert;
//        myCert = SecCertificateCreateWithData(NULL, myCertData);    // 2
//        [request setCaCertificate:myCert];
//        [request setValidatesSecureCertificate:YES];
//    }
//    else
//    {
   
        [request setValidatesSecureCertificate:NO];
//    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
//    [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
//    [request setDownloadCache:[ASIDownloadCache sharedCache]];

   // }
    //设置cookie
//    NSHTTPCookie *cookie = [CHKeychain load:K_USER_COOKIE_VALUE];
//    if (cookie) {
//        [request setUseCookiePersistence:NO];
//        [request setRequestCookies:[NSMutableArray arrayWithObjects:cookie, nil]];
//    }else{
//        [request setUseCookiePersistence:YES];
//    }
    return request;
}
-(NetTransObj*)getNetObjByAPITag:(int)nTag
{
    for(int n = 0; n < [arrReq count]; n++)
    {
        NetTransObj* obj = [arrReq objectAtIndex:n];
        if(obj.nApiTag == nTag)
        {
            return obj;
        }
    }
    return nil;
}
-(void)removeNetObj:(NetTransObj*)netObj
{
    if (netObj) {
        if(netObj.requst != nil)
        {
            netObj.requst.delegate = nil;
            [netObj.requst cancel];
            [arrReq removeObject:netObj];
        }
        netObj = nil;
    }
}
- (void)removeAllObj
{
    for(int n = 0; n < [arrReq count];n++)
    {
        NetTransObj* obj = [arrReq objectAtIndex:n];
        obj.requst.delegate = nil;
        [obj.requst cancel];
        //NSLog(@"requst cancel");
    }
    [arrReq removeAllObjects];

}
+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef*)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    
    OSStatus securityError = errSecSuccess;
    
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:@"" forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if (securityError == 0) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failed with error code %d",(int)securityError);
        return NO;
    }
    return YES;
}
-(void)removeObjsByUI:(id)ui
{
    NSMutableArray *temp = [NSMutableArray array];
    for(int n = 0; n < [arrReq count];n++)
    {
        NetTransObj* obj = [arrReq objectAtIndex:n];
        if(obj.uinet == ui)
        {
            obj.requst.delegate = nil;
            [obj.requst cancel];
            //NSLog(@"requst cancel");
            [temp addObject:obj];
            obj = nil;
        }
    }
    [arrReq removeObjectsInArray:temp];
    [temp removeAllObjects];
}

/*------------------------------------------------------ */
/*---------------------- API---------------------------- */
/*------------------------------------------------------ */

/* 用户 */
//#define API_USER_GET_SALT_API             @"v3/user/getsalt"                               /* 请求盐 */
// 调用登陆后盐立即失效，每次调用登陆接口前需要重新调用盐接口



-(void)API_get_msg_list:(id)transdel PageIndex:(NSInteger)pageIndex Limit:(NSInteger)limit{
    NSString *requestName = API_GET_MES_LIST;
    NSString *requestPort = BASEURLHOST;
    
    MessageListTrans *webTrans = [[MessageListTrans alloc]init:transdel nITag:t_API_GET_MES_LIST nApi:t_API_GET_MES_LIST ];
    NSString* strurl= [NSString stringWithFormat:@"%@://%@/%@",BASEURLSCHEME,requestPort,requestName];
    webTrans.requst = [self post:strurl];
    if(webTrans.requst == nil)
    {
        return;
    }
    
    webTrans.requst.delegate = webTrans;
    
    /* set param */
    
    [webTrans.requst setPostValue:@"getmsg" forKey:@"action"];
    
    [webTrans.requst setPostValue:[NSString stringWithFormat:@"%ld",(long)pageIndex] forKey:@"page"];
    [webTrans.requst setPostValue:[NSString stringWithFormat:@"%ld",(long)limit] forKey:@"limit"];
    
    [arrReq addObject:webTrans];
    [webTrans.requst startAsynchronous];
}
@end
