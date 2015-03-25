//
//  PaySDK.m
//  mystoreCustomer
//
//  Created by Liu Zhichao on 14-12-25.
//  Copyright (c) 2014年 ChangShengTianDi std. All rights reserved.
//

#import "PaySDK.h"
#import "iToast.h"
#define KBANKMODEL  @"00"
@implementation PayEntity
@synthesize pay_str,order_no,order_type;

- (void)setPayEntity:(NSDictionary *)dic{
    if ([dic objectForKey:@"pay_str"]) {
        self.pay_str = [dic objectForKey:@"pay_str"];
    }
    if ([dic objectForKey:@"order_no"]) {
        self.order_no = [dic objectForKey:@"order_no"];
    }
    if ([dic objectForKey:@"order_type"]) {
        self.order_type = [dic objectForKey:@"order_type"];
    }
}
@end
static PaySDK *instance;

@implementation PaySDK

@synthesize payTarget,_delegate,_isWeiXinSession,order_no;

+ (id)payInstanceWithTarget:(PaySDKType)type PayEntity:(PayEntity*)entity ViewController:(id)vc  {
    
    
  
    if (instance == nil)
    {
        instance = [[PaySDK alloc] init];
        
    }
        instance.order_no = entity.order_no;
        if(type == PaySDKTypeAlipay)
        {
            AlixPay * alixpay = [AlixPay shared];
            int ret = [alixpay pay:entity.pay_str applicationScheme:@"myappone"];
            
            if (ret == kSPErrorAlipayClientNotInstalled) {
                
             
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您还没有安装支付宝快捷支付，请先安装。" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                
                [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                    
                    if(buttonIndex==1){
                        NSString * URLString = @"http://itunes.apple.com/cn/app/id535715926?mt=8";
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
                    }
                    
                }];
                
               
            }
            else if (ret == kSPErrorSignError) {
                NSLog(@"签名错误！");
            }
        }else if (type == PaySDKTypeWeiXin){
            PayReq *request = [[PayReq alloc] init];
            
            
            NSLog(@"entity.pay_str is %@",entity.pay_str);
            NSDictionary  *jsonDic = (NSDictionary*)entity.pay_str;
            
            //NSDictionary  *jsonDic = [str objectFromJSONString];
            //request.type = 0;
            
            request.openID =[jsonDic objectForKey:@"appid"];
            request.partnerId =[jsonDic objectForKey:@"partner"];
            
            request.prepayId = [jsonDic objectForKey:@"prepayid"];
            request.nonceStr = [jsonDic objectForKey:@"noncestr"];
            NSString *timeStr =[jsonDic objectForKey:@"timestamp"];
            request.timeStamp = [timeStr intValue];
            
            request.package =@"Sign=WXPay";
            request.sign =[jsonDic objectForKey:@"sign"];
            
            [WXApi safeSendReq:request];
        }else if (type==PaySDKTypeUppay){
          //    //假数据－－－请求接口。返回xml进行传递
                //    UIViewController *viewCtrl = nil;
                //    //////////////////////////
                //
                //    self.hidesBottomBarWhenPushed = YES;
                //    NSString * order = str;
                //    viewCtrl = [LTInterface getHomeViewControllerWithType:0 strOrder:order andDelegate:self];
                //    [self.navigationController pushViewController:viewCtrl animated:YES];
                
                [UPPayPlugin startPay:entity.pay_str mode:KBANKMODEL viewController:vc delegate:self];
            
        }
    
    
    return instance;
}

#pragma mark-发送消息
+ (void)postNotofocation{
    NSLog(@"post table refresh");
    NSDictionary *dc = [[NSDictionary alloc]init];
    if (instance.order_no.length>0) {
    
  
        dc = [NSDictionary dictionaryWithObject:@"300" forKey:@"type"];
        
       // [[NetTrans getInstance]API_Is_pay_success:self order_no:instance.order_no];
    }else{
        
        
        dc = [NSDictionary dictionaryWithObject:@"0" forKey:@"type"];
      
    }
    //发出通知
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil userInfo:dc];
    

}



+ (void)postFail{
    NSLog(@"post Fail");
//    if (instance.order_no.length>0) {
//        
//     [[NetTrans getInstance]API_Is_pay_success:self order_no:instance.order_no];
//    }
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fail" object:nil userInfo:nil];
    
    
}

#pragma mark- 支付宝回调

//独立客户端回调函数


+(void)Aliparse:(NSURL *)url application:(UIApplication *)application {
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
    if (result)
    {
        
        if (result.statusCode == 9000)
        {
            [[iToast makeText:@"支付成功"] show];
            [self postNotofocation];
            /*
             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
             */
            
            //交易成功
            //            NSString* key = @"签约帐户后获取到的支付宝公钥";
            //			id<DataVerifier> verifier;
            //            verifier = CreateRSADataVerifier(key);
            //
            //			if ([verifier verifyString:result.resultString withSign:result.signString])
            //            {
            //                //验证签名成功，交易结果无篡改
            //			}
            
        }
        else
        {
            //交易失败
            [[iToast makeText:@"支付失败"] show];
            //[self postNotofocation];
            [self postFail];
        }
    }
    else
    {
        //失败
    }
    
}
+ (AlixPayResult *)resultFromURL:(NSURL *)url {
    NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [[AlixPayResult alloc] initWithResultString:query];
    
}

+ (AlixPayResult *)handleOpenURL:(NSURL *)url {
    AlixPayResult * result = nil;
    
    if (url != nil && [[url host] compare:@"safepay"] == 0) {
        result = [self resultFromURL:url];
    }
    
    return result;
}


#pragma mark- 微信回调


+(void) onResp:(BaseResp*)resp
{
    //    if([resp isKindOfClass:[SendMessageToWXResp class]])
    //    {
    //        NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
    //        NSString *strMsg = [NSString stringWithFormat:@"发送媒体消息结果:%d", resp.errCode];
    //
    //        NSLog(@"%@:%@",strTitle, strMsg);
    //    }
    //    else if([resp isKindOfClass:[SendAuthResp class]])
    //    {
    //        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
    //        NSString *strMsg = [NSString stringWithFormat:@"Auth结果:%d", resp.errCode];
    //
    //        NSLog(@"%@:%@",strTitle, strMsg);
    //    }
    
    //微信支付回调
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess: {
                [[iToast makeText:@"支付成功"] show];
                [self postNotofocation];
            }
                break;
            default: {
                
                [[iToast makeText:@"支付失败"] show];
               // [self postNotofocation];
                [self postFail];
            }
                break;
        }
    }
}

#pragma mark -银联回调

+ (void)UPPayPluginResult:(NSString *)result
{
      NSLog(@"银联回调:%@",result);
    if ([result isEqualToString:@"success"]) {
         [[iToast makeText:@"支付成功"] show];
             [self postNotofocation];
    }else{
        [[iToast makeText:@"支付失败"] show];
        [self postFail];
    }
}
#pragma mark - Application life cycle

/**
 * @description 当应用从后台唤起时，应调用此方法，需要完成退出当前登录状态的功能
 */
- (void)applicationDidBecomeActive{
    
}

+ (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation wxDelegate:(id)wxDelegate{
    
    //[[url absoluteString] hasPrefix:@"wx50b922b0ff031f56"]||[[url absoluteString] hasPrefix:@"THCustomer://safepay"]
    
    if ([[url absoluteString] hasPrefix:@"wx50b922b0ff031f56"])
    {
        return  [WXApi handleOpenURL:url delegate:self];
    }else if([[url absoluteString] hasPrefix:@"myappone://safepay"]){
        [self Aliparse:url application:annotation];
    }
    
    
    return YES;
    
}






 @end
