//
//  AppDelegate.h
//  myappone
//
//  Created by wbw on 12-8-27.
//  Copyright (c) 2012年 wbw All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "SHSShareViewController.h"
#import "WXApi.h"
#import "NetTransObj.h"
#import "SWRevealViewController.h"
//#import "MessageRSViewController.h"
//#import "SinaWeibo.h"
#import "PaySDK.h"
//#import "BMapKit.h"

BOOL Globe_isLogin;
BOOL isRememberPassword;


/*------------------------- -------------------------*/
#define WBDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)
/*------------------------- -------------------------*/

/*------------------------- -------------------------*/
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate, WXApiDelegate, UIAlertViewDelegate,UINetTransDelegate>
{

    CGFloat _curStatusBarHeight;
    BOOL isDealingWithoutRefresh; //一些页面在程序切换回后台的时候不刷新
//    
//    SinaWeibo *sinaweibo;
//    
    UITabBarController *tabBarController;
    
    Reachability  *hostReach;
    
    /** _isLaunchNetStatus
     *@brief  用来判断用户已经登陆后是否要跳转到微通社或逛一逛。启动时登陆和未登录分别跳到微通社或者逛一逛。
     在按home键或者使用时断网再联网的情况：监控到网络变化时判断用户已经登陆后不需要做跳转。
     *1:启动时，大于1:使用过程中*/
    NSInteger    _isLaunchNetStatus;
    BOOL _isBecomeActiveFromPush;//是否从push后台返回程序
    BOOL _isFromShare;
    BOOL _isFromLogin;
    NSString *areaStr;
    NSDictionary *_pushData; //推送消息的数据
    BOOL _isFromActive;//从外部启动
    BOOL _isFristLaunch;//标识第一次开启程序且，退出登陆或进后台设为no
//    BMKMapManager* _mapManager; 
}
/*------------------------- -------------------------*/
@property (assign, nonatomic) BOOL _isFristLaunch;
@property (assign, nonatomic) BOOL _isFromActive;
@property (strong, nonatomic) UIWindow        *window;
@property (strong, nonatomic) UIWindow        *_debugWindow;
@property (nonatomic, assign) CGFloat         curStatusBarHeight;
@property (nonatomic, assign) BOOL  _isBecomeActiveFromPush;
@property (nonatomic)         BOOL            isDealingWithoutRefresh;
//@property (readonly, nonatomic) SinaWeibo     *sinaweibo;
@property  (nonatomic,assign) BOOL            _isFromShare;
@property  (nonatomic,assign) BOOL            _isFromLogin;
@property (nonatomic,assign) int              _isFromAlipay;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (nonatomic,strong)  NSString        *areaStr;
@property (strong, nonatomic) Reachability    *hostReach;
@property (strong, nonatomic) SWRevealViewController *_swController;

@property (nonatomic, strong) NSDictionary *_pushData; //推送消息的数据
/*------------------------- -------------------------*/

-(void)registerForRemoteNotificationToGetToken;
/* 设置有无新消息的小红点的显示和隐藏 */
-(void)setBadgeValue_HaveNewCardOrCoupon;
/* 设置有无新朋友消息的小红点的显示和隐藏 */
-(void)setBadgeValue_HaveNewFriend:(BOOL)isHaveNewFriend;
@end
