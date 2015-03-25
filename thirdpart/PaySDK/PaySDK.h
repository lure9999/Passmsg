//
//  PaySDK.h
//  mystoreCustomer
//
//  Created by Liu Zhichao on 14-12-25.
//  Copyright (c) 2014年 ChangShengTianDi std. All rights reserved.
//
#import "PaySDKTypeDef.h"
#import "AlixPay.h"

#import <Foundation/Foundation.h>
#import "UIAlertView+Blocks.h"
#import "WXApi.h"
#import "UPPayPluginDelegate.h"
#import "UPPayPlugin.h"

@interface PayEntity : NSObject

@property (nonatomic, copy) NSString * pay_str;    // 支付发送的字符串
@property  (nonatomic, copy) NSString *order_no;

@property  (nonatomic, copy) NSString *order_type;
@end


@protocol PaySDKDelegate;





@interface PaySDK: NSObject<WXApiDelegate,UPPayPluginDelegate>
{
    id<PaySDKDelegate> __weak _delegate;
    PaySDKType payTarget;
    BOOL _isWeiXinSession; //是否是微信好友分享，yes是好友分享，no是朋友圈分享
    NSString *order_no;
}
@property (nonatomic, weak) id<PaySDKDelegate> _delegate;
@property PaySDKType payTarget;
@property  (nonatomic,assign) BOOL            _isWeiXinSession;
@property  (nonatomic,strong)     NSString *order_no;
//通用调用支付方法
+ (id)payInstanceWithTarget:(PaySDKType)type PayEntity:(PayEntity*)entity ViewController:(id)vc;



+ (void)postNotofocation;
+ (void)postFail;
+ (AlixPayResult *)handleOpenURL:(NSURL *)url;

+ (void)Aliparse:(NSURL *)url application:(UIApplication *)application;
- (void)applicationDidBecomeActive;
+ (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation wxDelegate:(id)wxDelegate;
//

@end



@protocol PaySDKDelegate <NSObject>

@optional

- (void)KRShareDidPay:(PaySDK *)paySDK;

@end

