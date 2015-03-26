//
//  AppDelegate.m
//  myappone
//
//  Created by wbw on 12-8-27.
//  Copyright (c) 2012年 wbw All rights reserved.
//

#import "AppDelegate.h"
#import "SDImageCache.h"
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
#import "ASIHTTPRequest.h"
#import "CHKeychain.h"
#import "MACROS_P.h"

#import "AlixPay.h"
#import <sys/utsname.h>
#import <ShareSDK/ShareSDK.h>




//5个ROOTVC
#import "TabOneVC.h"
#import "TabTwoVC.h"
#import "TabThreeVC.h"
#import "TabFourVC.h"
#import "TabFiveVC.h"

//push存储devicetoken的user default key


enum
{
    ENUM_PUSH_GOODS_ON = 1,  //1. 上架商品通知
    ENUM_PUSH_GOODS_OFF,     //2.下架商品通知
    ENUM_PUSH_STORE,         //3.门店通知
    ENUM_PUSH_DM,            //4.促销活动通知
    ENUM_PUSH_ORDER,         //5.订单通知
    ENUM_PUSH_FRIEND_NEW,    //6.新朋友通知
    ENUM_PUSH_COUPON,        //7.发放优惠券通知
    ENUM_PUSH_MEM_CARD,      //8.我的微店通知（会员卡）
    ENUM_PUSH_SHACK,         //9. 摇一摇奖品详情
    ENUM_PUSH_IM,            //10.IM信息
    ENUM_PUSH_WTS,           //11,微通社消息
};

enum{
    ENUM_ALERT_VERTION_POWER = 110, //强制更新alert
    ENUM_ALERT_VERTION_UPDATE,      //建议更新alert
    ENUM_ALERT_PUSH,                //push的alert
};



@implementation AppDelegate

@synthesize window = _window;
@synthesize _debugWindow;
@synthesize curStatusBarHeight = _curStatusBarHeight;
@synthesize isDealingWithoutRefresh;
@synthesize _isFromLogin;
@synthesize tabBarController;
@synthesize _isFromShare,_isFromAlipay;
@synthesize areaStr;
@synthesize _swController;
@synthesize _pushData;
@synthesize hostReach;
@synthesize _isBecomeActiveFromPush;
@synthesize _isFromActive;
@synthesize _isFristLaunch;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    _isLaunchNetStatus = 0;
    _isFristLaunch = YES;
    // [self addVesionControl];
    //百度地图
    //    _mapManager = [[BMKMapManager alloc] init];
    //    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    //    BOOL ret = [_mapManager start:@"IDtOFcPYNd1FQhsRvVoDgWUS"  generalDelegate:self];
    //    if (!ret) {
    //        NSLog(@"manager start failed!");
    //    }
    
    /*--------------- 监测网络情况 -------------*/
    
    self.hostReach = [Reachability reachabilityForInternetConnection];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    [self.hostReach startNotifier];
    /*************************友盟统计 start**************************/
    //  [MobClick startWithAppkey:@"5304111d56240b6f9c090f74"];
    
    /*************************友盟统计 start**************************/
    
    /*************************session相关 start**************************/
    //将存储的user agent信息放入ASIHttpRequest,用来替换session
    /* 设置user agent 用来避免webview请求导致的api接口需要重新登录 start */
    NSString *olduseragent = [ASIHTTPRequest defaultUserAgentString];
    NSString *temuseragent = nil;
    NSRange range = [olduseragent rangeOfString:@"||"];
    if (range.length > 0) {
        temuseragent = [olduseragent substringToIndex:range.location];
    }else{
        temuseragent = olduseragent;
    }
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:USER_LOGIN_USER_ID];
    NSString *userkey = [[NSUserDefaults standardUserDefaults] objectForKey:USER_LOGIN_USER_key];
    NSString *useragent = [NSString stringWithFormat:@"%@||userid=%@;user_skey=%@",temuseragent,userid,userkey];
    [ASIHTTPRequest setDefaultUserAgentString:useragent];
    NSDictionary *dictionary = [NSDictionary
                                dictionaryWithObjectsAndKeys:
                                useragent,
                                @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    /* 设置user agent 用来避免webview请求导致的api接口需要重新登录 end */
    /*************************session相关 end**************************/
    
    /*-------   push notice   ----------*/
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert];
    }
    /*--------------- -------------*/
    [[SDImageCache sharedImageCache] cleanDisk];
    _curStatusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    /*--------------- -------------*/
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    /* 显示status bar, 风格为透明 */
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    if (IOS_VERSION < 7.0)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    
    
    /* 创建tabbar viewcontroller */
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_bg.png"];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor grayColor], UITextAttributeTextColor,
                                                       nil,nil] forState:UIControlStateNormal];
    //    UIColor *titleHighlightedColor = [UIColor colorWithRed:153/255.0 green:192/255.0 blue:48/255.0 alpha:1.0];
    UIColor *titleHighlightedColor = RGBCOLOR(238, 146, 0);
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil,nil] forState:UIControlStateSelected];
    
    /* 创建五个viewcontroller */
    TabOneVC *rootvc1 = [[TabOneVC alloc] initWithNibName:nil bundle:nil];
    
    TabTwoVC *rootvc2 = [[TabTwoVC alloc] initWithNibName:nil bundle:nil];
    TabThreeVC *rootvc3 = [[TabThreeVC alloc] initWithNibName:nil bundle:nil];
    TabFourVC *rootvc4 = [[TabFourVC alloc] initWithNibName:nil bundle:nil];
    TabFiveVC *rootvc5 = [[TabFiveVC alloc] initWithNibName:nil bundle:nil];
    
    /* 创建五个viewcontroller的导航条 */
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:rootvc1];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:rootvc2];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:rootvc3];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:rootvc4];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:rootvc5];
    
    NSDictionary *dictNavTitle = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIColor blackColor],UITextAttributeTextColor, //字体颜色
                                  [UIFont boldSystemFontOfSize:20],UITextAttributeFont,//title字体
                                  //   UIOffsetMake(0, 0),UITextAttributeTextShadowOffset,//title的阴影offset
                                  // RGBCOLOR(246, 246, 246),UITextAttributeTextShadowColor,//title的阴影颜色
                                  nil];
    nav1.navigationBar.titleTextAttributes = dictNavTitle;
    nav2.navigationBar.titleTextAttributes = dictNavTitle;
    nav3.navigationBar.titleTextAttributes = dictNavTitle;
    nav4.navigationBar.titleTextAttributes = dictNavTitle;
    nav5.navigationBar.titleTextAttributes = dictNavTitle;
    
    if (IOS_VERSION < 7.0)
    {
        [nav1.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg_ios6.png"] forBarMetrics:UIBarMetricsDefault];
        [nav2.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg_ios6.png"] forBarMetrics:UIBarMetricsDefault];
        [nav3.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg_ios6.png"] forBarMetrics:UIBarMetricsDefault];
        [nav4.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg_ios6.png"] forBarMetrics:UIBarMetricsDefault];
        [nav5.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg_ios6.png"] forBarMetrics:UIBarMetricsDefault];
        
        
        nav1.navigationBar.clipsToBounds = YES;
        nav2.navigationBar.clipsToBounds = YES;
        nav3.navigationBar.clipsToBounds = YES;
        nav4.navigationBar.clipsToBounds = YES;
        nav5.navigationBar.clipsToBounds = YES;
        
    }
    else
    {
        [nav1.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
        [nav2.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
        [nav3.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
        [nav4.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
        [nav5.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
        
    }
    
    
    /* 将五个NavigationController放到tabbar的数组中 */
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,nav4,nav5, nil];
    
    // self.tabBarController.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3, nil];
    
    self.tabBarController.tabBar.clipsToBounds = YES;
    self.tabBarController.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"tab_selection_Indicator_1X1.png"];
    
    SWRevealViewController *revealViewController = [[SWRevealViewController alloc] initWithRearViewController:nil frontViewController:self.tabBarController];
    revealViewController.frontViewShadowRadius = 5;
    
    //右侧隐藏视图
    // MyStoreRightViewController *rightViewController = [[MyStoreRightViewController alloc] init];
    //[rightViewController setUserId:nil];
    // revealViewController.rightViewController = rightViewController;
    
    //浮动层离右边距的宽度
    revealViewController.rightViewRevealWidth = 220;
    [revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    
    
    //    MyStoreViewController *vc = (MyStoreViewController*)myVc;
    //    rightViewController._dataTransDelegate = vc;
    //    rightViewController._hideControllerDelegate = revealViewController;
    //
    //    [vc._rightBtn addTarget:revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
    //    [vc.view addGestureRecognizer:revealViewController.panGestureRecognizer];
    self._swController = revealViewController;
    
    //test tabbar view controller
    self.window.rootViewController = self._swController;
    
    //DefaultLoaddingViewController *dlvc = [[DefaultLoaddingViewController alloc] init];
    //self.window.rootViewController = dlvc;
#ifdef DEBUG_SHOWLOG
    [self addDebugWindow];
#endif
    
    [self.window makeKeyAndVisible];
    
    
    //
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:@"UserLoginUseCaptcha"];//初始化用户的获取验证码
    
    // 初始化ShareSDK应用, ShareSDK应用中的Appkey
    [ShareSDK registerApp:kShareSDKAppKey];
    // 初始化社交平台
    [self initializePlat];
    
    //sinaweibo
    
    
    /*监测是否需要自动登陆*//*注释原因：首先判断是否登陆，已经登陆则不需要再登陆，只有在没有登陆的情况才不需要检查是否自动登陆*/
    
    // [self.tabBarController setSelectedIndex:TAB_1];
    
    //    [self checkIfNeedAutoLogin];
    //    [self.tabBarController setSelectedIndex:TAB_GOU_WU_QIANG];
    /*--------------- -------------*/
    
    
    
    [self performSelector:@selector(performTransition) withObject:nil afterDelay:0];
    self.isDealingWithoutRefresh = NO;
    
    //初始化数据
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:nil,USER_NAME, nil];
    [CHKeychain save:D_USERSECURITYINFO data:dic];
    
    //处理push
    NSDictionary *userPushInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    [self copePush:userPushInfo];
    _isFromActive = YES;
    
    //判断是否登录，并获取跳转的页面
    // [[NetTrans getInstance] API_APP_ISLOGIN_AND_JUMP_FUNC:self];
    
    return YES;
}
/*
 #pragma mark ============================== NSNotificationCenter
 
 - (void)postNotofocation{
 NSLog(@"post table refresh");
 
 //发出通知
 [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil userInfo:nil];
 
 self._isFromAlipay=0;
 }
 
 - (void)postNotofocation2{
 NSLog(@"post table refresh2");
 
 //发出通知
 [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh2" object:nil userInfo:nil];
 
 //self._isFromAlipay=0;
 }
 
 
 - (void)postNotofocation1{
 NSLog(@"post page goto ");
 
 //发出通知
 [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh1" object:nil userInfo:nil];
 
 self._isFromAlipay=0;
 }
 
 
 
 //支付宝加入
 - (BOOL)isSingleTask{
 struct utsname name;
 uname(&name);
 float version = [[UIDevice currentDevice].systemVersion floatValue];//判定系统版本。
 if (version < 4.0 || strstr(name.machine, "iPod1,1") != 0 || strstr(name.machine, "iPod2,1") != 0) {
 return YES;
 }
 else {
 return NO;
 }
 }
 */
-(void)pushUserFriendAction{
    // NSString *strUserId = [NSString stringWithFormat:@"%@", [self._pushData objectForKey:@"id"]];
//    if([self.tabBarController selectedIndex] == TAB_WEI_TONG_SHE)
//    {
//        UINavigationController *controller = (UINavigationController *)self.tabBarController.selectedViewController;
//        
//        [controller popToRootViewControllerAnimated:NO];
//        
//    }
//    [self.tabBarController setSelectedIndex:TAB_WEI_TONG_SHE];
//    
    //                 UINavigationController *controller = (UINavigationController *)self.tabBarController.selectedViewController;
    //                TabFourViewController *friend = (TabFourViewController*)controller.topViewController;
    //                [friend showRsView:strUserId];
    
    /*
     if ([SecurityMethod G_is_login]) {
     [self.tabBarController setSelectedIndex:TAB_ZHAO_PENG_YOU];
     UINavigationController *controller = (UINavigationController *)self.tabBarController.selectedViewController;
     if ([controller.topViewController isKindOfClass:[TabFourViewController class]] == YES) {
     TabFourViewController *friend = (TabFourViewController*)controller.topViewController;
     //    [friend controllerChangeFromPush];
     }
     
     } else {
     NSLog(@"isNOtLogin");
     [UserLoginViewController show:self.tabBarController type:FRIENDS_NEW_TYPE isReturnPar:YES];
     }*/
}

-(void)pushSKUPriceChangeAction{
    //    [self.tabBarController setSelectedIndex:TAB_GOU_WU_QIANG];
    //    UINavigationController *controller = (UINavigationController *)self.tabBarController.selectedViewController;
    //    if ([controller.topViewController isKindOfClass:[TabThreeViewController class]] == YES) {
    //            TabThreeViewController *three = (TabThreeViewController*)controller.topViewController;
    //        [three skuChangePriceFromPush:nil Goods_id:nil Store_id:nil];
    //    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //   [SDWebImageManager.sharedManager.imageCache clearMemory];
    //   [SDWebImageManager.sharedManager.imageCache clearDisk];
}
#pragma mark - myfunction
-(void)endWelcome:(id)sender
{
    [[self.window viewWithTag:1002] removeFromSuperview];
    [[self.window viewWithTag:1001] removeFromSuperview];
    [self.tabBarController setSelectedIndex:TAB_1];
}
-(void)performTransition
{
    CATransition *transition = [CATransition animation];
    transition.duration = 3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    //[self.rootVc.view.layer addAnimation:transition forKey:nil];
    
    //self._defaultview.hidden = YES;
    
    //    [self performSelector:@selector(toremoveDefaultView) withObject:nil afterDelay:0];
}


// 全局监控网络状态变化
- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    [self netWorking:status];
}

- (void)netWorking:(NetworkStatus)status
{
    if (status == NotReachable) {
        [[iToast makeText:@"目前您处于无网络状态"] show];
        // [SecurityMethod G_set_isLogin:YES];
        // [[XmppTrans getInstance] disconnect];
    }else{
        _isLaunchNetStatus++;
        if([SecurityMethod G_is_login]){
            
        }
        //        [[NetTrans getInstance] API_user_profile:self UserID:nil];
    }
    
}

// 初始化社交平台
- (void)initializePlat
{
    // 新浪微博
    [ShareSDK connectSinaWeiboWithAppKey:kSinaWeiboAppKey
                               appSecret:kSinaWeiboAppSecret
                             redirectUri:kSinaWeiboAppRedirectURI];
    
    // 腾讯微博
    /*
    [ShareSDK connectTencentWeiboWithAppKey:kTencentWeiboAppKey
                                  appSecret:kTencentWeiboAppSecret
                                redirectUri:kTencentWeiboAppRedirectURI
                                   wbApiCls:nil];
    */
    // 微信
    [ShareSDK connectWeChatWithAppId:kWeiXinAppKey
                           appSecret:kWeiXinAppSecret
                           wechatCls:[WXApi class]];
    
    
}

#pragma mark - WeChat delegate method

-(void) onReq:(BaseReq*)req
{
    
}

-(void) onResp:(BaseResp*)resp
{
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //    if ([[url absoluteString] hasPrefix:TAOBAOCALLBACKURL]) {
    //        TopAppConnector *appConnector = [TopAppConnector getAppConnectorbyAppKey:TAOBAOAPPKEY];
    //        [appConnector receiveMessageFromApp:[url absoluteString]];
    //        return YES;
    //    }
    if ([[url absoluteString] hasPrefix:@"wx50b922b0ff031f56://pay"]||[[url absoluteString] hasPrefix:@"myappone://safepay"])
    {////测试 注册支付回调
        return  [PaySDK application:application openURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:nil];
        
    }
    else if([[url absoluteString] hasPrefix:@"sinaweibosso.1985482134"])
    {
        // return [self.sinaweibo handleOpenURL:url];
    }
    else if (_isFromShare || [[url absoluteString] hasPrefix:@"wx50b922b0ff031f56://oauth"]) {
        return [ShareSDK handleOpenURL:url
                     sourceApplication:sourceApplication
                            annotation:annotation
                            wxDelegate:self];
    }
    
    return YES;
}
//独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSLog(@"handleOpenURL:%@",url);
    if([[url absoluteString] hasPrefix:@"sinaweibosso.1985482134"]){
        // return   [self.sinaweibo handleOpenURL:url];
    }
    
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}
/*
 - (void)parse:(NSURL *)url application:(UIApplication *)application {
 
 //结果处理
 AlixPayResult* result = [self handleOpenURL:url];
 
 if (result)
 {
 
 if (result.statusCode == 9000)
 {
 
 // *用公钥验证签名 严格验证请使用
 //result.resultString与result.signString验签
 
 
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
 }
 }
 else
 {
 //失败
 }
 
 }
 
 - (AlixPayResult *)resultFromURL:(NSURL *)url {
 NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 #if ! __has_feature(objc_arc)
 return [[[AlixPayResult alloc] initWithResultString:query] autorelease];
 #else
 return [[AlixPayResult alloc] initWithResultString:query];
 #endif
 }
 
 - (AlixPayResult *)handleOpenURL:(NSURL *)url {
 AlixPayResult * result = nil;
 
 if (url != nil && [[url host] compare:@"safepay"] == 0) {
 result = [self resultFromURL:url];
 }
 
 return result;
 }
 */

-(UIImage *) scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(BOOL)checkIfNeedAutoLogin
{
    /** @note 取消自动登陆，将始终返回NO
     NSDictionary *userSecurityDict = [CHKeychain load:KEY_USERSECURITYINFO];
     if ([[userSecurityDict objectForKey:KEY_USER_PASSWORD_IS_REMEMBERED] isEqualToString:@"1"]) {
     NSString *username = [userSecurityDict objectForKey:KEY_USER_NAME];
     NSString *password = [userSecurityDict objectForKey:KEY_USER_PASSWORD];
     [self sendLoginRequestWithUsername:username andPassword:password];
     return YES;
     }else{
     return NO;
     }
     */
    return NO;
}

-(void)sendLoginRequestWithUsername:(NSString *)userName andPassword:(NSString *)userPassword
{
    [[NetTrans getInstance] API_user_login:self
                                  UserName:userName
                                  PassWord:userPassword
                                   Captcha:@""];
}

//add sun
//监测版本
-(void)getSoftWareVersionFromHost
{
    //[[NetTrans getInstance] API_version_check:self AgentID:@"1"];
}
//end
//版本号比较大小
-(BOOL) isOlderVersionThan:(NSString*)otherVersion SelfVersion:(NSString *)selfversion
{
    return ([selfversion compare:otherVersion options:NSNumericSearch] == NSOrderedAscending);
}
-(BOOL) isNewerVersionThan:(NSString*)otherVersion SelfVersion:(NSString *)selfversion
{
    return ([selfversion compare:otherVersion options:NSNumericSearch] == NSOrderedDescending);
}
#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)atabBarController didSelectViewController:(UIViewController *)viewController
{
    UINavigationController *navC = (UINavigationController *)viewController;
    [navC popToRootViewControllerAnimated:NO];
//    
//    if (atabBarController.selectedIndex != TAB_GOU_WU_QIANG) {
//        
//        BOOL isreture  = [self._swController hideFrontViewRight:YES];
//        if (isreture) {
//            [tabBarController setSelectedIndex:TAB_GOU_WU_QIANG];
//            return;
//        }
//    }
    
    
    
}


#pragma mark ============================== push消息处理
/* 推送消息回调函数 */
- (void)application:(UIApplication*)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *str = [NSString stringWithFormat:@"%@",deviceToken];
    
    NSString *token = nil;
    token = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    //  NSLog(@">>>>>> Get token is %@",token);
#ifdef DEBUG_SHOWLOG
    //将debug信息写入文件
    [DebugInfoFileManager saveDebugInfo:[NSString stringWithFormat:@">>>>>> Get token is %@",token]];
#endif
    
    //保存 device token 令牌,并且去掉空格
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:USER_DEFAULT_PUSH_DEVICE_TOKEN];
    
    //将令牌发送到服务器
    //[[NetTrans getInstance] API_add_token:self Device_Token:token];
}

/* 如果device token获取失败则需要重新获取一次 */
- (void)application:(UIApplication*)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    // NSLog(@">>>>>> Get token Error:%@",err);
#ifdef DEBUG_SHOWLOG
    //将debug信息写入文件
    [DebugInfoFileManager saveDebugInfo:[NSString stringWithFormat:@">>>>>> Get token Error:%@",err]];
#endif
    //注册失败尝试重新注册
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(registerForRemoteNotificationToGetToken) userInfo:nil repeats:NO];
}
//处理PUSH消息
-(void)copePush:(NSDictionary *)userInfo
{
    _isBecomeActiveFromPush = YES;
    if ([userInfo objectForKey:@"aps"] == nil )
    {
        return;
    }
    
    if (![[userInfo objectForKey:@"aps"] isKindOfClass:[NSDictionary class]])
    {
        return;
    }
    
    NSDictionary *message = [userInfo objectForKey:@"aps"];
    
    
    if ([userInfo objectForKey:@"data"] != [NSNull null])
    {
        NSString *alerMessage = [message objectForKey:@"alert"];
        self._pushData = [userInfo objectForKey:@"data"];
        
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"消息通知" message:alerMessage  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertV.tag = ENUM_ALERT_PUSH;
        [alertV show];
        
    }else
    {
        NSString *alerMessage = [message objectForKey:@"alert"];
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"消息通知" message:alerMessage  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertV.tag = ENUM_ALERT_PUSH;
        [alertV show];
    }
    
}
/* 收到消息后处理消息 */
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //    {
    //         "aps" : { "alert" : "甘家口下架商品小白兔" , "badge" : 1},
    //         "data" : { "t":"2", "id":"3432" }
    //    }
    NSLog(@"ReceiveRemoteNotif userInfo %@",userInfo);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 1];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [self copePush:userInfo];
}


/* 向服务器申请发送token 判断事前有没有发送过 */
- (void)registerForRemoteNotificationToGetToken
{
    
#ifdef DEBUG_SHOWLOG
    //将debug信息写入文件
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *strtoken = [userDefaults objectForKey:USER_DEFAULT_PUSH_DEVICE_TOKEN];
    NSLog(@">>>>>>register token::%@",strtoken);
    
    [DebugInfoFileManager saveDebugInfo:[NSString stringWithFormat:@">>>>>>register token::%@",strtoken]];
#endif
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (
          UIRemoteNotificationTypeAlert |   UIRemoteNotificationTypeBadge |
          UIRemoteNotificationTypeSound)];
    }
}

#pragma mark ============================== alertView 代理
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
#pragma mark ============================== alertView 代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
}
/* 设置有无新朋友消息的小红点的显示和隐藏 */
-(void)setBadgeValue_HaveNewFriend:(BOOL)isHaveNewFriend
{
    if (isHaveNewFriend)
    {
        UIView* tabFriend = [self.tabBarController.tabBar viewWithTag:TAG_Friend_HAVE_NEWS];
        
        if (tabFriend) {
            return;
        }
        /* 给朋友小红点 */
        UIView *newsFriend = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5*4-25, 5, 10, 10)];
        newsFriend.backgroundColor = [UIColor redColor];
        newsFriend.layer.cornerRadius = 5.0f;
        newsFriend.tag = TAG_Friend_HAVE_NEWS;
        [self.tabBarController.tabBar addSubview:newsFriend];
    }
    else
    {
        UIView* tabFriend = [self.tabBarController.tabBar viewWithTag:TAG_Friend_HAVE_NEWS];
        
        if (tabFriend) {
            [tabFriend removeFromSuperview];
        }
    }
}
/* 设置有无新消息的小红点的显示和隐藏 */
-(void)setBadgeValue_HaveNewCardOrCoupon
{
    NSString *cardNew = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULT_HAVE_CARD_NEWS];
    NSString *couponNew = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULT_HAVE_COUPON_NEWS];
    /*
     if (couponNew && couponNew.integerValue>0)
     {
     // 给优惠券小红点
     UIView *newsCoupon = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5*2-25, 5, 10, 10)];
     newsCoupon.backgroundColor = [UIColor redColor];
     newsCoupon.layer.cornerRadius = 5.0f;
     newsCoupon.tag = TAG_COUPON_HAVE_NEWS;
     [self.tabBarController.tabBar addSubview:newsCoupon];
     }else
     {
     for (UIView *view in self.tabBarController.tabBar.subviews) {
     if (view.tag == TAG_COUPON_HAVE_NEWS) {
     [view removeFromSuperview];
     }
     }
     }
     */
    if ((cardNew && cardNew.integerValue > 0 ) || (couponNew && couponNew.integerValue>0))
    {
        /* 给我的微店加小红点 */
        UIView *newsMystore = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-25, 5, 10, 10)];
        newsMystore.backgroundColor = [UIColor redColor];
        newsMystore.layer.cornerRadius = 5.0f;
        newsMystore.tag = TAG_MYSTORE_HAVE_NEWS;
        [self.tabBarController.tabBar addSubview:newsMystore];
    }
    else
    {
        for (UIView *view in self.tabBarController.tabBar.subviews) {
            if (view.tag == TAG_MYSTORE_HAVE_NEWS) {
                [view removeFromSuperview];
            }
        }
    }
    
    
}
#pragma mark ============================== 网络代理
-(void)requestFailed:(int)nTag withStatus:(NSString*)status withMessage:(NSString*)errMsg;
{
    
}
-(void)responseSuccess:(NSMutableArray *)arrData nTag:(int)nTag
{
    if(t_API_ADD_Token == nTag)
    {
        
    }
    else if(t_API_SET_PUSH_NUM == nTag)
    {
        NSLog(@"pushnum");
    }
    else if (nTag == t_API_FRIEND_MESSAGECOUNT_API) {
        
    }
}
-(void)responseSuccessObj:(id)netTransObj nTag:(int)nTag
{
    if (t_API_VERSION_API == nTag) {
        //        VersionEntiy *version = (VersionEntiy *)netTransObj;
        //        //NSString *verNum = version._version;
        //
        //        if ([version._update isEqualToString:@"1"]) {
        //            //强制升级
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"监测到您目前用的版本不是新版本" delegate:self cancelButtonTitle:nil otherButtonTitles:@"请下载新版本", nil];
        //            alert.tag = ENUM_ALERT_VERTION_POWER;
        //            [alert show];
        //
        //        }else if ([version._update isEqualToString:@"2"])
        //        {
        //            //前往appstore下载
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"监测到您目前用的版本不是新版本" delegate:self cancelButtonTitle:@"暂时忽略" otherButtonTitles:@"前往", nil];
        //            alert.tag = ENUM_ALERT_VERTION_UPDATE;
        //            [alert show];
        //        }
        
        
    }else if (t_API_USER_LOGIN_API == nTag){
        /*设置全局是否已经登陆的变量*/
        [SecurityMethod G_set_isLogin:YES];
        
        //        UserDetailInfoEntity *userLoginInfo = (UserDetailInfoEntity *)netTransObj;
        //        [CHKeychain save:KEY_USERSERVICEINFO data:userLoginInfo];
        //        [userLoginInfo updateMainInfo];
        //        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        //        [userDefaults setBool:[userLoginInfo._is_rest boolValue] forKey:@"UserLoginUseCaptcha"];
        //
        //        RefleshManager *refMgr = [RefleshManager sharedRefleshManager];
        
    }else if (t_API_USER_GET_OTHER_USER_INFO_API == nTag){
        //        [SecurityMethod G_set_isLogin:YES];
        //        UserDetailInfoEntity *userLoginInfo = (UserDetailInfoEntity *)netTransObj;
        //
        //        [CHKeychain save:KEY_USERSERVICEINFO data:userLoginInfo];
        //        [userLoginInfo updateMainInfo];
    }
    
    if (nTag == t_API_APP_ISLOGIN_AND_JUMP )
    {
        //根据返回要跳转的页面进行跳转
        //self.window.rootViewController = self._swController;
        //[self.window makeKeyAndVisible];
        
        //是否登录
        
        
    }
}
-(void)addVesionControl
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:version
                                              forKey:@"version_preference"];
    
    NSString *build = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    [[NSUserDefaults standardUserDefaults] setObject:build
                                              forKey:@"build_preference"];
    
    NSString *githash = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"GITHash"];
    [[NSUserDefaults standardUserDefaults] setObject:githash
                                              forKey:@"githash_preference"];
    
}


@end
