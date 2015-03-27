//
//  NetTrans.h
//  TestForNet
//
//  Created by xiu fiona on 13-2-21.
//  Copyright (c) 2013年 xiu fiona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"


/* 百度统计开关 */
#define BAIDUTONGJI

#pragma mark ================================ HTML5 page
#define HTML_STORE_MORE(storeID) ([NSString stringWithFormat:@"page/page/bu_more?store_id=%@",storeID])
#define HTML_STORE_DM(storeID) ([NSString stringWithFormat:@"page/bu_dm?store_id=%@",storeID])

//宏定义来控制API接口是否含v3
//#define API_VERSION_3
#ifdef API_VERSION_3
#define API_VERSION  @"v3/"
#else
#define API_VERSION  @""
#endif


#pragma mark ================================ API

/*------------------------- -------------------------*/
/*-----------------------API start ------------------*/
/*------------------------- -------------------------*/
/* 用户 */

#define API_USER_GET_SALT_API             ([NSString stringWithFormat:@"%@user/getsalt", API_VERSION])                                     /* 请求盐 */
#define API_USER_LOGIN_API                ([NSString stringWithFormat:@"%@user/login", API_VERSION])                                         /* 用户登陆 */
#define API_USER_LOGOUT_API               ([NSString stringWithFormat:@"%@user/logout", API_VERSION])                                       /* 用户登陆 */
#define API_USER_PLATFORM_BINDING_API     ([NSString stringWithFormat:@"%@user/platform/binding", API_VERSION])                   /* 用户平台绑定 */
#define API_USER_PLATFORM_LOGIN_API       ([NSString stringWithFormat:@"%@user/platform/login", API_VERSION])                       /* 用户平台登录 */
#define API_USER_INVIT_CODE_API           ([NSString stringWithFormat:@"%@user/store/invitation/code", API_VERSION])         /* 用户注册邀请码 */
#define API_USER_EXIST_API                ([NSString stringWithFormat:@"%@user/user_exist", API_VERSION])                               /* 用户是否存在 */


#define API_USER_GET_CAPTCHA_API          ([NSString stringWithFormat:@"%@message/captcha", API_VERSION])                               /* 获取验证码 */
#define API_USER_REGISTER_API             ([NSString stringWithFormat:@"%@user/register", API_VERSION])                                   /* 用户注册 */
#define API_USER_UPDATE_API               ([NSString stringWithFormat:@"%@user/update", API_VERSION])                                       /* 用户更新个人信息 */
#define API_USER_RESET_PASSWORD_API       ([NSString stringWithFormat:@"%@user/password/reset_password", API_VERSION])     /* 用户重置密码 *//* 见USER_UPDATA_PASSWORD_API */
#define API_USER_FORGET_PASSWORD_API      ([NSString stringWithFormat:@"%@user/password/forget_password", API_VERSION])   /* 用户忘记密码 *//* 见USER_UPDATA_PASSWORD_API */
#define API_USER_UPDATE_PASSWORD_API      ([NSString stringWithFormat:@"%@user/password/update", API_VERSION])                     /* 用户修改密码 */
#define API_USER_LIST_GET_API             ([NSString stringWithFormat:@"%@user/list", API_VERSION])                                           /* 获取其他用户列表 *//* 包括粉丝列表 *//* 包括群友列表 */

#define API_USER_GET_OTHER_USER_INFO_API  ([NSString stringWithFormat:@"%@user/profile", API_VERSION])                                     /* 获取别人的用户信息 */
#define API_USER_GET_CITY                 ([NSString stringWithFormat:@"%@user/location/list", API_VERSION])                         /*获取全国省，城市列表*/
#define API_USER_GET_CITYID               ([NSString stringWithFormat:@"%@region/getCityId", API_VERSION])                             /*根据省市名称返回城市id*/


#define API_STORE_LIST_MORE_API           ([NSString stringWithFormat:@"%@mystore/subscribes/more", API_VERSION])




#define API_GET_MES_LIST @"index.php"
#pragma mark ============================== 快支付




/*------------------------- -------------------------*/
/*-----------------------统计   ------------------*/
/*------------------------- -------------------------*/
enum{
    tj_AddTag = 1,
};
/*------------------------- -------------------------*/
/*-----------------------API end   ------------------*/
/*------------------------- -------------------------*/

/*------------------------- -------------------------*/
/*-----------------------API tag   ------------------*/
/*------------------------- -------------------------*/
enum{
    t_API_USER_LOGIN_API = 0,
    t_API_USER_GET_SALT_API,
    t_API_USER_LOGOUT_API,
    t_API_USER_PLATFORM_BINDING_API,
    t_API_USER_PLATFORM_LOGIN_API,
    t_API_USER_INVIT_CODE_API,
    t_API_USER_GET_CAPTCHA_API,
    t_API_USER_REGISTER_API,
    t_API_USER_UPDATE_API,
    t_API_USER_RESET_PASSWORD_API,
    t_API_USER_FORGET_PASSWORD_API,
    t_API_USER_UPDATE_PASSWORD_API,
    t_API_USER_LIST_GET_API,
    t_API_USER_GET_OTHER_USER_INFO_API,
    t_API_USER_GET_CITY,
    t_API_USER_GET_CITYID,
    t_API_USER_GET_OWN_CITY,
    t_API_USER_EXIST,
    t_API_STORE_HOME_DATA,
    t_API_STORE_LIST_API,
    t_API_STORE_TOPLIST_API,
    t_API_STORE_FORMAT_API,
    t_API_STORE_LIST_SUBSCRIBED_API,
    t_API_STORE_FORMATLIST_API,
    t_API_STORE_DM_LIST_API,
    t_API_STORE_MY_SUB_TAG_API,
    t_API_STORE_MY_SUB_TAG_USERTAG_API,
    t_API_STORE_PUSH_HOT_TAG_API,
    t_API_STORE_PUSH_RELATIVE_TAG_API,
    t_API_TAG_UPDATA,
    t_API_SET_PUSH_NUM,
    t_API_TAG_UPDATA_DELETE,
    t_API_STORE_PUSH_RECOMMOND_API,
    t_API_GOODS_UNBIND_TAG,
    t_API_STORE_MAIN_TAG_API ,
    t_API_STORE_TAG_DM_LIST_API,
    t_API_STORE_TAG_GOODS_LIST_API,
    t_API_STORE_TAG_GOODS_ZAN_API,
    t_API_STORE_TAG_GOODS_ADDZAN_API,
    t_API_STORE_BU_GOODS_LIST_API,
    t_API_SUMERIZED_API,
    t_API_SUMERIZED_LAUD_API,
    t_API_EMPLOYEESUMERIZED_API,
    t_API_EMPLOYEEUSER_API,
    t_API_SEARCH_STORE_API,
    t_API_SEARCH_FORMAT_STORE_API,
    t_API_SEARCH_TAG_API,
    t_API_SEARCH_GOODS_API,
    t_API_STORE_SEARCH_GOODS_API,
    t_API_SEARCH_STORE_TAG_API,
    t_API_MYSTORE_TAGS_API,
    t_API_MYSTORE_API,
    t_API_EMPLOYEESTORE_TAGS_API,
    t_API_ZAN_TAGS_API,
    t_API_EMPLOYEE_MYSTORE_LAUD,
    t_API_EMPLOYEE_FANS_GOODS,
    t_API_GOODS_DETAIL,
 
    t_API_SUBSCRIBE_STATUS,
    t_API_SUBSCRIBE_SUB,
    t_API_SUBSCRIBE_UN,
    t_API_CART_STORE_LIST,
    t_API_CART_GOODS_LIST,
    t_API_CART_UPDATE_LIST,
    t_API_CART_GOODS_TOTAL,
    t_API_WTS_SETTINGS,
    t_API_WTS_MESSAGE_LIST,
    t_API_WTS_SYSTEM_MESSAGE_LIST,
    t_API_FEED_BACK_API,
    t_API_RETURN_GOOD_API,
    t_API_GET_RETURN_GOOD_API,
    t_API_VERSION_API ,
    t_API_CHECK_VERIFY_CODE_API ,
    t_API_TWO_SCAN_USER,
    t_API_USER_SEARCH,
    t_API_FRIEND_ANALYSE_API,
    t_API_FRIEND_ADD_API,
    t_API_FRIEND_LIST_API,
    t_API_FRIEND_DELETE_API,
    t_API_FRIEND_SEARCH_API,
    t_API_FRIEND_MESSAGECOUNT_API,
    t_API_FRIEND_MESSAGELIST_API,
    t_API_FRIEND_MESSAGEAGREE_API,
    t_API_FRIEND_MESSAGEDELETE_API,
    t_API_FRIEND_JUDGE_API,
    t_API_FRIEND_USER_INFO_API,
    t_API_FRIEND_SWEEP_CODE_ADD_API,
    t_API_FRIEND_REMARK,
    
    t_API_CAPTCHA_CHECK,
    t_API_CARD_AND_COUPON_ENTRY,
    t_API_VCARD_APPLY,
    t_API_VCARD_CHECK_VALID,
    t_API_VCARD_LIST,
    t_API_VCARD_BIND,
    t_API_VCARD_DETAIL,
    t_API_VCARD_UNBIND,
    t_API_COUPON_LIST,
    t_API_COUPON_DETAIL,
    t_API_COUPON_DELETE,
    t_API_COUPON_INFO,
    t_API_COUPON_ACQUIRE,
    t_API_CUS_ALLCOUPON_LIST,
    
    t_API_BU_LIST,
    t_API_BU_INFO,
    t_API_BU_DETAIL_INFO,
    t_API_SHOPPING_ADD,
    t_API_SHOPPING_LIST_ADD,
    t_API_SHOPPING_LIST,
    t_API_ADD_Token,
    t_API_PUSH_MESSAGE,
    t_API_Goods_Url,
    
    
    t_API_GOODS_ATTR,
    t_API_ORDER_SUBMIT,
    t_API_ORDER_PAYACTION,
    t_API_BUY_PLATFORM_CANCELORDER_API,
    t_API_BUY_PLATFORM_FINISHORDER_API,
    t_API_MYORDERLIST_API,
    t_API_RETURNLIST_API,
    t_API_BUY_PLATFORM_ORDERPAY_API,
    t_API_BUY_PLATFORM_BANKPAY_API,
    t_API_BUY_PLATFORM_WXPAY_API,
    t_API_GET_ORDER_INFO,
    t_API_ADDCART_GOODS,
    t_API_CART_GOODSLISET_API,
    t_API_DELETEGOODS_API,
    t_API_UPDATETOTAL_API,
    t_API_ORDER_GET_AMOUNT,
    t_API_CART_GOODS_NUM,
    
    t_API_SHAKE,
    t_API_SHAKE_LIST,
    t_API_SHAKE_VERTIFY_CODE,
    t_API_SHAKE_CERTAIN,
    t_API_SHAKE_CANCEL,
    t_API_SHAKE_ACTIVETYLIST,
    
    
    t_API_ORDER_ADDRESS_LIST,
    t_API_ORDER_ADDRESS_ADD,
    t_API_ORDER_ADDRESS_UPDATE,
    t_API_ORDER_ADDRESS_DELETE,
    t_API_ORDER_ADDRESS_SET,
    t_API_ORDER_AREA_LIST,
    t_API_ORDER_REGION_GET,
    t_API_ORDER_SETTLEMENT,
    
    t_API_BU_CATEGORY_LIST,
    t_API_CATEGORY_CHILD_LIST,
    t_API_BU_BRAND_LIST,
    t_API_MY_STORE_ORDER_LIST,
    t_API_MY_STORE_BRAND_LIST,
    t_API_MY_STORE_ORDER_OTHER_LIST,
    t_API_GOODS_LIST_API,
    
    //微通社接口
    t_API_WTS_MESSAGE_LIST_V2,
    t_API_WTS_MESSAGE_DETAIL,
    t_API_WTS_MESSAGE_COMMENT_LIST_V2,
    t_API_WTS_MESSAGE_LUASUSER_LIST_V2,
    t_API_WTS_MESSAGE_LAUD_V2,
    t_API_WTS_MESSAGE_COMMENT_V2,
    t_API_WTS_MESSAGE_LAUD_STATUS_V2,
    
    //第三方分享统计
    t_API_SHARE_TONGJI,
    t_API_SHARE,
    t_API_SHARE_WTS,
    
    //微店首页2.21
    t_API_HOME_PAGE,
    t_API_HOME_PAGE_GPS,
    t_API_ALL_STORE_LIST,
    t_API_ALL_EMPLOYEES_LIST,
    t_API_ALL_STORE_DUSTRY_LIST,
    t_API_ALL_MORE_SHAKE_LIST,
    t_API_ALL_MORE_GOODS_LIST,
    //获取店员信息，进行IM对话，2.22
    t_API_IM_EMPLOYEE_INFO_V222,
    
    //判断用户是否登录，并获取跳转的页面
    t_API_APP_ISLOGIN_AND_JUMP,
    t_API_APP_GYG_JUMP_URL,
    t_API_APP_GYG_RELATED_STORES,
    t_API_APP_LOCATION_STORE_LIST,
    
    t_API_CUS_COUPON_HAVE_NEWS,
    t_API_CUS_CARD_HAVE_NEWS,
    t_API_CUS_PREFERENTIAL_LIST,
    
    //快支付
    t_API_QUERY_ORDER,
    t_API_CANCEL_ORDER,
    t_API_IS_PAY_SUCCESS,
    t_API_QUICK_ORDER_LIST,
    
    //我的微店
    t_API_GET_MES_LIST,
};

//网络通信总控
@interface NetTrans : NSObject
{
    NSMutableArray* arrReq;//value:NetTransObj
     NSMutableArray* arrTongJiKey;
}

@property (nonatomic, strong) NSMutableArray* arrReq;
@property (nonatomic, strong) NSMutableArray* arrTongJiKey;
+(NetTrans*)getInstance;
-(ASIFormDataRequest *)post:(NSString*)strUrl;
-(ASIHTTPRequest *)get:(NSString *)strUrl;
-(void)removeObjsByUI:(id)ui;//CANCEL界面发起的所有request
-(void)removeNetObj:(id)netObj;//移掉某一指令
-(void)removeAllObj;//移除所有request
-(id)getNetObjByAPITag:(int)nTag;
//-(void)API_get_goods_zan_status:(id)transdel BUID:(NSString*)buID GoodsID:(NSString*)goodsID;
//-(void)API_wts_system_message_list:(id)transdel PageIndex:(NSInteger)pageIndex Limit:(NSInteger)limit;
//-(void)API_wts_message_list:(id)transdel PageIndex:(NSInteger)pageIndex Limit:(NSInteger)limit;
//-(void)API_laud_goods_list:(id)transdel  UserID:(NSString*)userID;
//-(void)API_mystore_home:(id)transdel UserID:(NSString*)userID PageIndex:(NSInteger)pageIndex Limit:(NSInteger)limit;
//-(void)API_EMPLOYEE_mystore_home:(id)transdel ID:(NSString*)Id Type:(NSString*)type;
//-(void)API_EMPLOYEE_laud_goods:(id)transdel ID:(NSString*)Id Type:(NSString*)type;
//-(void)API_subscribe_status:(id)transdel Type:(id)type IDS:(NSString*)Ids;
//-(void)API_user_get_city:(id)transdel Type:(NSString*)type ProvinceID:(NSString*)provinceID  PageIndex:(NSInteger)pageIndex Limit:(NSInteger)limit;
/*--------------------- 登陆相关-------------------------- */

/* 用户 */
- (void)API_user_get_salt:(id)transdel userName:(NSString *)username;
- (void)API_user_login:(id)transdel userName:(NSString*)userName passWord:(NSString*)password code:(NSString *)code cid:(NSString *)cid;
//#define API_USER_LOGIN_API                ([NSString stringWithFormat:@"%@user/login", API_VERSION])                                /* 用户登陆 */
-(void)API_user_login:(id)transdel UserName:(NSString*)userName PassWord:(NSString*)password Captcha:(NSString*)captcha;
//#define API_USER_LOGOUT_API               ([NSString stringWithFormat:@"%@user/logout", API_VERSION])                               /* 用户登陆 */
-(void)API_user_logout:(id)transdel;
//#define API_USER_PLATFORM_BINDING_API     ([NSString stringWithFormat:@"%@user/platform/binding", API_VERSION])                     /* 用户平台绑定 */
-(void)API_user_platform_binding:(id)transdel Origin:(NSString*)origin Uuid:(NSString*)uuid Name:(NSString*)name Register_user_agent:(NSInteger)agent;
//#define API_USER_PLATFORM_LOGIN_API       ([NSString stringWithFormat:@"%@user/platform/login", API_VERSION])                       /* 用户平台登录 */
-(void)API_user_platform_login:(id)transdel  Origin:(NSString*)origin Uuid:(NSString*)uuid;
//#define API_USER_INVIT_CODE_API           ([NSString stringWithFormat:@"%@user/store/invitation/code", API_VERSION])                /* 用户注册邀请码 */
//#define API_USER_GET_CAPTCHA_API          ([NSString stringWithFormat:@"%@message/captcha", API_VERSION])                           /* 获取验证码 */
-(void)API_user_get_captcha:(id)transdel Type:(NSString*)type Number:(NSString*)number curVersion:(NSString*)curVersion;
//#define API_USER_REGISTER_API             ([NSString stringWithFormat:@"%@user/register", API_VERSION])                             /* 用户注册 */
//-(void)API_user_register:(id)transdel
//                UserName:(NSString*)userName
//                   Email:(NSString*)email
//                  Mobile:(NSString*)mobile
//                 Captcha:(NSString*)captcha
//                    Code:(NSString*)code
//                Password:(NSString*)password
//                NickName:(NSString*)nickname
//                   Image:(NSString*)image
//                   Intro:(NSString*)intro
//                TrueName:(NSString*)truename
//                  Gender:(NSString*)gender
//                    City:(NSString*)city
//                Birthday:(NSString*)birthday;
-(void)API_user_register:(id)transdel
                  Mobile:(NSString*)mobile
                 Captcha:(NSString*)captcha
                    Code:(NSString*)code;
-(void)API_exist_user:(id)transdel userId:(NSString*)userId userType:(NSString*)userType;

//#define API_USER_UPDATE_API               ([NSString stringWithFormat:@"%@user/update", API_VERSION])                               /* 用户更新个人信息 */
-(void)API_user_update_info:(id)transdel
                     UserID:(NSString *)userID
                   NickName:(NSString*)nickname
                      Image:(NSString*)image
                      Intro:(NSString*)intro
                    BGImage:(NSString *)bgImage;

-(void)API_user_update_profile:(id)transdel
                      UserName:(NSString*)userName
                      NickName:(NSString*)nickname
                 IsChangeImage:(BOOL)isChangeImage
                         Image:(NSString*)image
                         Email:(NSString*)email
                        Mobile:(NSString*)mobile
                         Intro:(NSString*)intro
                      TrueName:(NSString*)truename
                        Gender:(NSString*)gender
                          City:(NSString*)city
                      Birthday:(NSString*)birthday;
-(void) API_user_update_shoppingWall:(id)transdel UserID:(NSString*)userID NickName:(NSString*)nickname UserIntro:(NSString*)intro IsChangeImage:(BOOL)isChangeImage ShoppingWallImage:(NSString*)shoppingWallImage;
//#define API_USER_UPDATE_PASSWORD_API      ([NSString stringWithFormat:@"%@user/password/update", API_VERSION])                      /* 用户修改密码 */
-(void)API_user_update_password:(id)transdel
                           Type:(NSString*)type
                    OldPassword:(NSString*)oldPassword
                    NewPassword:(NSString*)newPassword
                ConfirmPassword:(NSString*)confirmPassword
                         Mobile:(NSString*)mobile
                        Captcha:(NSString*)captcha;
//#define API_USER_LIST_GET_API             ([NSString stringWithFormat:@"%@user/list", API_VERSION])                                 /* 获取其他用户列表 *//* 包括粉丝列表 *//* 包括群友列表 */
-(void)API_user_list_typeStoreTagFans:(id)transdel
                                   ID:(NSString*)Id
                              StoreID:(NSString*)storeID
                            PageIndex:(NSInteger)pageIndex
                                Limit:(NSInteger)limit;
-(void)API_user_list_typeUserTagFans:(id)transdel
                                  ID:(NSString*)Id
                              UserID:(NSString*)userID
                           PageIndex:(NSInteger)pageIndex
                               Limit:(NSInteger)limit;
-(void)API_user_list_typeTag:(id)transdel
                          ID:(NSString*)Id
                   PageIndex:(NSInteger)pageIndex
                       Limit:(NSInteger)limit;
//#define API_USER_GET_OTHER_USER_INFO_API  ([NSString stringWithFormat:@"%@user/profile", API_VERSION])                              /* 获取别人的用户信息 */
-(void)API_user_profile:(id)transdel UserID:(NSString*)userID;
//#define API_USER_GET_CITY                 ([NSString stringWithFormat:@"%@user/location/list", API_VERSION])/*获取全国省，城市列表*/
-(void)API_user_get_city:(id)transdel Type:(NSString*)type ProvinceID:(NSString*)provinceID  PageIndex:(NSInteger)pageIndex Limit:(NSInteger)limit;

-(void)API_user_get_cityId:(id)transdel Province_name:(NSString*)province_name City_name:(NSString*)city_name;
//#define API_USER_GET_OWN_CITY                 ([NSString stringWithFormat:@"%@user/location/list", API_VERSION])/*获取全国省，城市列表*/
-(void)API_user_get_own_city:(id)transdel Type:(NSString*)type ProvinceID:(NSString*)provinceID  PageIndex:(NSInteger)pageIndex Limit:(NSInteger)limit;


-(void)API_get_msg_list:(id)transdel PageIndex:(NSInteger)pageIndex Limit:(NSInteger)limit;

@end



