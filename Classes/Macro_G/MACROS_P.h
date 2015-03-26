//
//  defines.h
//  myappone
//
//  Created by wbw on 12-9-5.
//  Copyright (c) 2012年 ChangShengTianDi std. All rights reserved.
//

//#define BASEURL     @"http://172.20.150.85:8080//v3"
//#define BASEURL     @"http://172.20.110.50/store.json"

//#import "MessageHelp.h"
#import "iToast.h"
#import "CHKeychain.h"
#import "Utility.h"
#import "RefleshManager.h"
#import "SecurityMethod.h"
#import "Reachability.h"
#import "NSString+Addition.h"
#import "PublicMethod.h"


//宏定义来控制开发地址还是正式地址
//#define PRODUCT_HOST
/**********************地址配置 start**********************/
#ifdef PRODUCT_HOST

#define PUSHURLHOST          @"v5.msservices.mystore.com.cn"         //push的消息个数数字显示正式地址
#define HTTPSCERNAME     @"mystorehttps"

#define BASEURLHOST       @"roseapi.mystore.com.cn/v229"          //API调用正式地址
#define HTTPSURLHOST        @"roseapi.mystore.com.cn/v229" //@"new.wdpay.mystore.com.cn"                 //https:调用https

#define TWO_DIMEN_CODE_URL   @"http://h5.mystore.com.cn/register?"   //二维码头部定义的识别字符串正式地址
#define H5BASEURLHOST        @"http://h5.mystore.com.cn/"            //H5界面的基础地址
#define H5XUNZHANGBASEURLHOST        @"http://m.mystore.com.cn/"
#else /*PRODUCT_HOST*/

#define PUSHURLHOST          @"newtest.msservices.mystore.com.cn"      //push的消息个数数字显示测试地址
#define HTTPSCERNAME     @"mystorehttps_test"  //HTTPS证书

//#define BASEURLHOST          @"v229test.roseapi.mystore.com.cn" //
#define BASEURLHOST          @"testapi.mystore.com.cn/v230"        //API调用测试地址
#define HTTPSURLHOST @"testapi.mystore.com.cn/v230"
//#define HTTPSURLHOST         @"63.t.mystore.com.cn"

#define TWO_DIMEN_CODE_URL   @"http://test.m.mystore.com.cn/register?"//二维码头部定义的识别字符串测试地址

#define H5BASEURLHOST      @"http://test.h5.mystore.com.cn/" // @"http://test.m.mystore.com.cn/"         //H5界面的基础地址
#define H5XUNZHANGBASEURLHOST        @"http://t27.mystore.com.cn/"

#endif /*PRODUCT_HOST*/
/**********************地址配置 end**********************/

//宏定义来控制BASEURLHOST使用https协议还是http协议
#define BASEURL_HTTPS_PROTOCOL

#ifdef BASEURL_HTTPS_PROTOCOL
#define BASEURLSCHEME          @"https"
#else /*BASEURL_HTTPS_PROTOCOL*/
#define BASEURLSCHEME          @"http"

#endif /*BASEURL_HTTPS_PROTOCOL*/


//#define DEBUG_SHOWLOG  //打开调试界面窗口

#define ISIMVERSION //是否有im功能定义



//@"00":代表接入生产环境(正式版 本需要); @"01":代表接入开发测试环境(测 试版本需要)  银联支付;
#define KBANKMODEL  @"00"

#define WEB_STATUS_1        @"1"
#define WEB_STATUS_4        @"4"
#define WEB_STATUS_0        @"0"
#define WEB_STATUS_10000    @"10000"

#define PUBLISHER_UUID @"123"
/*
 * 版本记录
 * code 6 对应version 2.16
 * code 19 对应version 2.19
 * code 20 对应version 2.20
 * code 21 对应version 2.21
 * code 22 对应version 2.22
 * code 23 对应version 2.23
 * code 24 对应version 2.24
 * code 25 对应version 2.25
 * code 26 对应version 2.26
 * code 27 对应version 2.27
 */
#define K_VERSION_CODE      29     //version 2.29

/*------------------------- -------------------------*/
/*--------------------ios version--------------------*/
/*------------------------- -------------------------*/
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/*------------------------- -------------------------*/
/*-----------------------COLOR-----------------------*/
/*------------------------- -------------------------*/
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

#define HSVCOLOR(h,s,v) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]

#define RGBA(r,g,b,a) (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)

/*颜色--橙色，浅灰色，灰色*/
#define COLOR_MY_ORANGE      RGBCOLOR(238, 146, 0)
#define COLOR_MY_LIGHTGRAY   RGBCOLOR(239, 239, 244)
#define COLOR_MY_GRAY        RGBCOLOR(208, 208, 208)
#define COLOR_MY_GRAYFONT    RGBCOLOR(153, 153, 153)
#define COLOR_MY_GREEN       RGBCOLOR(48, 128, 20)
#define COLOR_MY_RED         RGBCOLOR(204, 0, 0)
#define COLOR_MY_TABLE_BG_GRAY    RGBCOLOR(223, 223, 223)
#define COLOR_MY_LIGHTGRAY_TWO    RGBCOLOR(243, 243, 243)
#define COLOR_MY_LIGHTGRAY_THREE    RGBCOLOR(248, 248, 248)
#define COLOR_MY_GRAYLINE    RGBCOLOR(238, 238, 238)
/*------------------------- -------------------------*/
/*-----------------------X Y W H--------------------*/
/*------------------------- -------------------------*/

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#define K_NAV_HEIGHT 44                   /* 导航条高度 */
#define K_TABBAR_HEIGHT  48               /* 选项tabbar的高度 */
#define K_NAV_AND_TABBAR_HEIGHT (48+44)   /* 导航条和选项卡的高度总和 */
#define K_STATUS_HEIGHT 20

#define K_SEARCH_BAR_HEIGHT 44            /* 搜索框统一高度 */

#define KStoreViewDMHeight 110            /* DM展示框的高度 */
#define KStoreViewIcarousHeight 130       /* 动态DM展示图片的高度 */

#define KSKU_WaterFlow_Cell_Width 96      /* 瀑布流每张图片的宽度 */
#define KSKU_WaterFlow_Offset     8       /* 瀑布流图片之间的间隔 */

#define KSKU_StoreInfoHeadView_Height 65  /* 商店信息头的高度 */
#define KSKU_StoreInfoHeadView_Offset 10  /* 商店信息头的间隔 */
#define KSKU_StoreInfoHeadView_ICON_Width 45 /* 商店信息头中图片的宽度 图片为正方形 */

#define KSKU_Store_Panel_Board_Height 35  /* 促销，商品，粉丝，群友的选项卡的高度*/

#define K_KeyBoard_height 252              /* 键盘的最大高度 */

#define kTabOneCellHeight 55 //144        /* 逛一逛的列表cell的高度 */
#define kTabOneKindCellHeight 65
#define KUser_MyStoreCellHeight 70        /* 我的微店列表cell高度 */
/*------------------------- -------------------------*/
/*-----------------------FONT------------------------*/
/*------------------------- -------------------------*/
#define KFONT_TYPE_0 @"Helvetica-Bold"  /* */
#define KFONT_TYPE_1 @"Helvetica"       /* */
#define KFONT_TYPE_2 @""
#define KFONT_TYPE_3 @""
#define KFONT_TYPE_4 @""

/*------------------------- -------------------------*/
/*-------------------NSUserDefaults--------------------*/
/*------------------------- -------------------------*/
#define USER_LOGIN_USER_ID                 @"user_login_user_id"
#define USER_LOGIN_USER_key                @"user_login_user_key"
#define USER_DEFAULT_PUSH_DEVICE_TOKEN     @"PUSH_DEVICE_TOKEN"
#define USER_DEFAULT_HAVE_CARD_NEWS        @"mystore_card_news"
#define USER_DEFAULT_HAVE_COUPON_NEWS      @"mystore_coupon_news"
/*------------------------- -------------------------*/
/*-------------------List type   --------------------*/
/*------------------------- -------------------------*/
#define K_LISTTYPE_LIST  1     /* 列表和瀑布流转换的类型中的列表类型 */
#define K_LISTTYPE_IMAGE 2     /* 列表和瀑布流转换的类型中的瀑布流类型 */

#define K_SELECT_ALL   1       /* 筛选购买状态 */
#define K_SELECT_NO    2       /* 非筛选购买 */

/*------------------------- -------------------------*/
/*-------------------TagDetail type   --------------------*/
/*------------------------- -------------------------*/
//typedef enum {
//    tagDetail_Store = 1,        /* 商店tag详情页      促销，商品，粉丝，群友 */
//    tagDetail_Search,           /* 搜索tag详情页      促销，商品，商户，群友 */
//    tagDetail_WallOwnSecrity,   /* 搜索tag详情页      促销，商品，商户，群友 */
//    tagDetail_WallOwnCZ,        /* 常购清单和周末清单   促销，商品，粉丝，群友 */
//    tagDetail_WallOwnCreate,    /* 我创建的清单        促销，商品，粉丝，群友 */
//    tagDetail_WallUser,         /* 我订阅的好友tag     促销，商品，粉丝，群友 */
//    tagDetail_WallStore,        /* 我订阅的商店tag     促销，商品，粉丝，群友 */
//} enumTagDetailType;

typedef enum{
    dmType_storeDM = 1,
    dmType_normalDM = 2,
} enumDMType;

//#define K_WALL_OWN_SECRITY_TAG_DETAIL 1  /* 私密清单           促销，商品*/
//#define K_WALL_OWN_COMMON_TAG_DETAIL  2  /* 常购清单      促销，商品，粉丝，群友 */
//#define K_WALL_OWN_WEEK_TAG_DETAIL    3  /* 周末清单 */
//#define K_WALL_OWN_CREATE_TAG_DETAIL  4  /* 我创建的清单        促销，商品，粉丝，群友 */
//#define K_WALL_USER_TAG_DETAIL        5  /* 我订阅的好友tag     促销，商品，粉丝，群友 */
//#define K_WALL_STORE_TAG_DETAIL       6  /* 我订阅的商店tag     促销，商品，粉丝，群友 */
//#define K_STORE_TAG_DETAIL            7  /* 商店tag详情页      促销，商品，粉丝，群友 */
//#define K_SEARCH_TAG_DETAIL           8  /* 搜索tag详情页      促销，商品，商户，群友 */
typedef enum{
    E_WALL_LAND_GOODS_DETAIL = 0,           /* 赞的商品清单 */
    E_WALL_OWN_SECRITY_TAG_DETAIL = 1,  /* 私密清单           促销，商品*/
    E_WALL_OWN_COMMON_TAG_DETAIL ,      /* 常购清单      促销，商品，粉丝，群友 */
    E_WALL_OWN_WEEK_TAG_DETAIL ,        /* 周末清单 */
    E_WALL_OWN_CREATE_TAG_DETAIL ,      /* 我创建的清单        促销，商品，粉丝，群友 */
    E_WALL_USER_TAG_DETAIL ,            /* 我订阅的好友tag     促销，商品，粉丝，群友 */
    E_WALL_STORE_TAG_DETAIL ,           /* 我订阅的商店tag     促销，商品，粉丝，群友 */
    E_STORE_TAG_DETAIL ,                /* 商店tag详情页      促销，商品，粉丝，群友 */
    E_SEARCH_TAG_DETAIL ,               /* 搜索tag详情页      促销，商品，商户，群友 */
    E_STORE_LAUD_TAG_DETAIL,
} enumTagDetailType;


typedef enum{
    E_ActionSheetType_InviteFriend = 1,
    E_ActionSheetType_InviteMutiFriend,
} enumActionSheetType;

/* 添加view的tag，会根据tag值remove*/
typedef enum {
    E_messageView_tag = 1000,
    E_micBgView_tag,
    E_cardPopover_tag,
    E_contactPopover_tag,
    E_menuBtn_tag,
    E_addrBookTipsView_tag,
} enumViewTag;

/* 我的微店的类型 */
typedef enum{
    E_MYSTORE_ME = 1,
    E_MYSTORE_CUSTOMER,
    E_MYSTORE_EMPLOYEE,
} enumMyStoreType;

#define K_PANEL_DM       1     /* 促销 */
#define K_PANEL_GOODS    2     /* 商品 */
#define K_PANEL_FANS     3     /* 粉丝 */
#define K_PANEL_TFRIENDS 4     /* 群友 */
#define K_PANEL_STORE    5     /* 商家 */
/*------------------------- -------------------------*/
/*-------------------tabthree type   --------------------*/
/*------------------------- -------------------------*/
#define TAB_THREE_OWEN     0
#define TAB_THREE_FANS  1
#define TAB_THREE_FRIEND   2

/*------------------------- -------------------------*/
/*-------------------User type   --------------------*/
/*------------------------- -------------------------*/
#define KEY_USERSERVICEINFO    @"UserInfoService"
#define KEY_USERSECURITYINFO   @"UserSecurityService"
#define KEY_USERIDENTITYCARD   @"UserIdentityCard"

#define KEY_USER_ID         @"user_id"
#define KEY_USER_NAME       @"user_name"
#define KEY_USER_EMAIL      @"email"
#define KEY_USER_MOBIL      @"mobile"
#define KEY_USER_CAPTCHA    @"captcha"
#define KEY_USER_PASSWORD   @"password"
#define KEY_USER_NICKNAME   @"nick_name"
#define KEY_USER_IMAGE      @"image"
#define KEY_USER_INTRO      @"intro"
#define KEY_USER_GENDER     @"gender"
#define KEY_USER_CITY       @"city_name"
#define KEY_USER_PROVINCE       @"province_name"
#define KEY_USER_CITYID       @"city_id"
#define KEY_USER_PROVINCEID       @"province_id"
#define KEY_USER_BIRTHDAY   @"birthday"
#define KEY_USER_TURENAME   @"true_name"
#define KEY_USER_SHOPINGWALLIMAGE   @"shoppingwall_image"
#define KEY_USER_PASSWORD_IS_REMEMBERED   @"password_is_remembered"
/*---------------------------------------------------*/
/*------------------ Platform info ------------------*/
/*---------------------------------------------------*/
#define KEY_PLATFORM_UUID            @"uuid"
#define KEY_PLATFORM_EXPIRATIONDATE  @"expirationdate"
#define KEY_PLATFORM_TOKEN           @"token"
#define KEY_PLATFORM_NICKNAME        @"nickname"

#define KEY_PLATFORM_SINA            @"sina"
#define KEY_PLATFORM_QQ              @"qq"
#define KEY_PLATFORM_QQWEIBO         @"qqweibo"
#define KEY_PLATFORM_RENREN          @"renren"
#define KEY_PLATFORM_DOUBAN          @"douban"
#define KEY_PLATFORM_TAOBAO          @"taobao"
#define KEY_PLATFORM_WEIXIN          @"wechat"

//是否已经绑定
#define KEY_PLATFORM_IS_BIND         @"isbind"

//新浪开放平台用户信息
#define KEY_PLATFORM_SINA_TOKEN         @"isbind"

#define USER_NAME @"userName"
#define D_USERSECURITYINFO @"userInfo"


/*------------------------- -------------------------*/
/*----------------------- type   --------------------*/
/*------------------------- -------------------------*/
#define SUB_STORE_TAG_TYPE 1  /* 订阅的门店的tag类型 */
#define PUSH_TAG_TYPE   2     /* 门店的热门推荐tag类型 */
#define KIND_TAG_TYPE   3     /* 门店的32种分类tag类型 */

#define STORE_TAG_DETAIL_VIEW_TYPE     1/* 商店tag详情的view类型 */
#define USER_OWEN_TAG_DETAIL_VIEW_TYPE 2/* 商店tag详情的view类型 */

#define SKU_PUSH_HOT_TAG @"999"

/*------------------------- --------------------------*/
/*-----------------------GPS Info --------------------*/
/*------------------------- --------------------------*/

#define USER_GPS_CITY_ID   @"user_gps_city_id"/* 城市ID */
#define USER_GPS_CITY_NAME @"user_gps_city_name"/* 城市名称 */
#define USER_GPS_NO_CITY_NAME @"user_no_gps_city_name"/* 不需要城市名称 */

/*------------------------- --------------------------*/
/*--------------Login Type 登陆类型 --------------------*/
/*------------------------- --------------------------*/

#define POP_TO_PARENT_LOGIN_TYPE 0
#define LOGIN_NAV_PUSH         1
#define MYSTORE_LOGIN_TYPE     2
#define FRIENDS_LOGIN_TYPE     3
#define WTS_LOGIN_TYPE         4
#define SKU_DETAIL_LOGIN_TYPE  5
#define DM_DETAIL_LOGIN_TYPE   6
#define OTHRE_LOGIN_TYPE       7
#define FRIENDS_NEW_TYPE       8
#define MORE_LOGIN_TYPE       9
/*------------------------- --------------------------*/
/*--------------Notification      --------------------*/
/*------------------------- --------------------------*/
#define NOTIFICATION_REFLASH                @"refleshData"
#define NOTIFICATION_TABELONE_REFLASH   @"tableOneReflesh"

/*------------------------- --------------------------*/
/*--------------Friend Type      --------------------*/
/*------------------------- --------------------------*/
#define ISFRIEND              0
#define NOTFRIEND             1
#define NOTINSTALLED          2

/*------------------------- --------------------------*/
/*--------------TabView Type      --------------------*/
/*------------------------- --------------------------*/
#define TAB_1             0  /* 逛一逛 */
#define TAB_2                  1  /* 我的优惠券 */
#define TAB_3               2  /* 微通社 */
#define TAB_4              3  /* 找朋友 */
#define TAB_5               4  /* 购物墙 */
#define TAB_6                   5  /* 更多 */
/*------------------------- --------------------------*/
/*--------------user Type      --------------------*/
/*------------------------- --------------------------*/
#define USER_ME                     1 /* 我自己的微店 */
#define USER_FANS                   2 /* 粉丝的微店 */
#define USER_T                      3 /* 群友 */
#define USER_FRIEND                 4 /* 好友的微店 */
#define USER_STORE                  5 /* 商店 */
#define USER_ME_FROMOTHER           6 /* 其他界面进来的我自己的微店 */
/*------------------------- --------------------------*/
/*--------------other user current in-----------------*/
/*------------------------- --------------------------*/
#define CURRENT_OTHER_USER    @"otherUserCurrent"

/*------------------------- --------------------------*/
/*--------------user Membership card -----------------*/
/*------------------------- --------------------------*/
#define KEY_CARD_STORENAME      @"keyCardStoreName"
#define KEY_CARD_NUM            @"keyCardNum"

/*------------------------- --------------------------*/
/*--------------if Uploaded Contact -----------------*/
/*------------------------- --------------------------*/
#define KEY_UPLOAD_CONTACTS     @"keyUploadContacts"

#define KEY_STORE_PAGE_LIMIT    10
#define KEY_GOODS_PAGE_LIMIT    20

// 导航条左右按钮
#define BARBUTTON(TITLE, SELECTOR) [UIBarButtonItem rightBarButtonItemWithTitle:TITLE target:self action:SELECTOR forControlEvents:UIControlEventTouchUpInside]

#define BACKBARBUTTON(TITLE, SELECTOR) [UIBarButtonItem backBarButtonItemWithTitle:TITLE target:self action:SELECTOR forControlEvents:UIControlEventTouchUpInside]


// 导航条和tab高度
#define NAVBAR_HEIGHT 44.0
#define TABBAR_HEIGHT 49.0
#define Height_Footer               30.0f

//提示文字
#define TEXT_LOADMORE               @"上拉可以加载更多..."
#define TEXT_LOADING                @"载入中..."


//全局tag
#define TAG_MYSTORE_HAVE_NEWS 100011
#define TAG_COUPON_HAVE_NEWS 100011
#define TAG_Friend_HAVE_NEWS 100013




#define kShareSDKAppKey      @"55dcfb48fd77"
#define kShareSDKAppSecret   @"3eafe64cf35f077dfd66e955edaf6a26"

#define kSinaWeiboAppKey             @"1985482134"
#define kSinaWeiboAppSecret          @"37f8260e7b51423f1393a61351f3a9be"
#define kSinaWeiboAppRedirectURI     @"http://www.mystore.com.cn/weibo_callback.php"

//#define kTencentWeiboAppKey             @"100624925"
//#define kTencentWeiboAppSecret          @"ef4dcc943d89c508c2db967d35b0316d"
//#define kTencentWeiboAppRedirectURI     @"http://www.qq.com"

#define kTencentWeiboAppKey               @"801261107"
#define kTencentWeiboAppSecret            @"8b08f921f5621e6f14a2b4d4526c40c8"
#define kTencentWeiboAppRedirectURI       @"http://www.mystore.com.cn"

#define kDoubanBroadAppKey             @"0077a5c719af2a470166f1554d0d7ed5"
#define kDoubanBroadAppSecret          @"e624d4fab3356f0a"
#define kDoubanBroadAppRedirectURI     @"http://www.qq.com"

#define kRenrenBroadAPPID              @"223954"
#define kRenrenBroadAppKey             @"bdc9de15d9084d3c81bfbcac2bb56425"
#define kRenrenBroadAppSecret          @"adc75e9663a64df292fbe75369b8167e"
#define kRenrenBroadAppRedirectURI     @"http://widget.renren.com/callback.html"

//#define kRenrenBroadAPPID              @"227690"
//#define kRenrenBroadAppKey             @"907af6ee06204a2aa618096f4a300b9d"
//#define kRenrenBroadAppSecret          @"b1c91a42d48f49998d7c3cbd0238424c"
//#define kRenrenBroadAppRedirectURI     @"http://widget.renren.com/callback.html"

#define kTencentQQAppKey     @"100291180"
#define kTencentQQAppSecret  @""

#define kWeiXinAppKey        @"wx50b922b0ff031f56"
#define kWeiXinAppSecret     @"a8f4dde1b4a20be159ba83fb7dd80219"

