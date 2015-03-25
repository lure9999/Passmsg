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

//店员商品
#define API_EMPLOYEE_GOODS                ([NSString stringWithFormat:@"%@employee/goods/recommend_index_list", API_VERSION])

#define API_STORE_LIST_API                ([NSString stringWithFormat:@"%@store/list", API_VERSION])                                        /* 某tag下的商店list */
#define API_STORE_FORMAT_API              ([NSString stringWithFormat:@"%@store/format", API_VERSION])                                    /* 逛一逛主页业态list */
#define API_STORE_FORMATLIST_API          ([NSString stringWithFormat:@"%@store/format/list", API_VERSION])                          /* 逛一逛主页业态商店list */
#define API_STORE_LIST_SUBSCRIBED_API     ([NSString stringWithFormat:@"%@store/sub/list", API_VERSION])                                /* 逛一逛主页我已经订阅的商户列表 */
#define API_STORE_TOPLIST_API             ([NSString stringWithFormat:@"%@store/toplist", API_VERSION])                                  /* 逛一逛主页商店最热list */
#define API_STORE_DM_LIST_API             ([NSString stringWithFormat:@"%@dm/list", API_VERSION])                                              /* 逛一逛商店--商店主页--展示的DM */
#define API_STORE_MY_SUB_TAG_API          ([NSString stringWithFormat:@"%@tag/list", API_VERSION])                                            /* 逛一逛商店--商店主页--我订阅的标签 *//* 用户默认的标签， */
#define API_STORE_PUSH_HOT_TAG_API        ([NSString stringWithFormat:@"%@tag/hot", API_VERSION])                                              /* 逛一逛商店--商店主页--热门推荐标签 */
#define API_STORE_PUSH_RELATIVE_TAG_API   ([NSString stringWithFormat:@"%@tag/relative", API_VERSION])                                    /* 商品相关标签，标签相关标签 */
#define API_TAG_UPDATA                    ([NSString stringWithFormat:@"%@tag/update", API_VERSION])                                        /* 创建或删除标签 */
#define API_STORE_PUSH_RECOMMOND_API      ([NSString stringWithFormat:@"%@tag/recommend", API_VERSION])                                  /* 商品的推荐标签，在SKU详情页使用 */
#define API_GOODS_UNBIND_TAG              ([NSString stringWithFormat:@"%@unbindgoods", API_VERSION])                                      /* 取消这个商品打的所有标签 */

#define API_STORE_MAIN_TAG_API            ([NSString stringWithFormat:@"%@category/offcial/store/tag", API_VERSION])        /* 逛一逛商店--商店主页--系统分类标签 */
/* 门店标签，门店默认标签，用户标签，用户默认标签，订阅商店的标签，订阅好友的标签，见STORE_MY_SUB_TAG_API */
#define API_STORE_HOME_DATA_API           ([NSString stringWithFormat:@"%@store/home", API_VERSION])
#define API_STORE_TAG_GOODS_LIST_API      ([NSString stringWithFormat:@"%@goods/list", API_VERSION])                                        /* 逛一逛商店--商店主页--标签--商品列表 *//* 获取列表的同时，已经获取商品的详细信息 */
#define API_GOODS_LIST_API                ([NSString stringWithFormat:@"%@goods/list", API_VERSION])                                        /*新增接口*/
#define API_STORE_TAG_GOODS_ZAN_API       ([NSString stringWithFormat:@"%@goods/getlaudstatus", API_VERSION])                      /* 商品详情--获取赞状态 */
#define API_STORE_TAG_GOODS_ADDZAN_API    ([NSString stringWithFormat:@"%@goods/laud", API_VERSION])                                        /* 商品详情--加赞或取消 */
//#define STORE_TAG_FANS_LIST_API       @"")    /* 逛一逛商店--商店主页--标签--粉丝列表 *//* 获取用户列表中可以获取粉丝列表，见 USER_LIST_GET_API */
//#define STORE_TAG_TFRIENDS_LIST_API   @"")    /* 逛一逛商店--商店主页--标签--群友列表 *//* 获取用户列表中可以获取群友列表，见 USER_LIST_GET_API */
#define API_SUMERIZED_API                 ([NSString stringWithFormat:@"%@summarize", API_VERSION])                                         /* 我的微店仪表盘*/
#define API_SUMERIZED_LAUD_API            ([NSString stringWithFormat:@"%@summarize/laud", API_VERSION])                               /* 赞的仪表盘 */
#define API_EMPLOYEESUMERIZED_API         ([NSString stringWithFormat:@"%@employee/mystore/count", API_VERSION])               /* 店员的微店的仪表盘 */
#define API_EMPLOYEEUSER_API              ([NSString stringWithFormat:@"%@employee/profile", API_VERSION])                           /*店员信息*/
#define API_SEARCH_STORE_API              ([NSString stringWithFormat:@"%@search/store", API_VERSION])                                   /* 搜索商户*/
#define API_SEARCH_FORMAT_STORE_API       ([NSString stringWithFormat:@"%@store/format/search", API_VERSION])                     /* 业态搜索商户*/
#define API_SEARCH_TAG_API                ([NSString stringWithFormat:@"%@search/tag", API_VERSION])                                       /* 搜索标签*/
#define API_SEARCH_GOODS_API              ([NSString stringWithFormat:@"%@search/goods", API_VERSION])                                   /* 搜索商品*/
#define API_SEARCH_STORE_TAG_API          ([NSString stringWithFormat:@"%@api/home/search", API_VERSION])                             /* 搜索门店标签*/
#define API_STORE_SEARCH_GOODS_API        ([NSString stringWithFormat:@"%@store/searchgoods", API_VERSION])                             /* 搜索门店内商品*/
#define API_MYSTORE_TAGS_API              ([NSString stringWithFormat:@"%@mystore/home", API_VERSION])                                    /* 我的购物墙tag列表获取 */
#define API_EMPLOYEESTORE_TAGS_API        ([NSString stringWithFormat:@"%@employee/mystore/home", API_VERSION])                  /*店员购物墙的tag列表*/
#define API_ZAN_TAGS_API                  ([NSString stringWithFormat:@"%@mystore/laudgoods", API_VERSION])                          /* 赞的tag列表获取 */
//我的微店赞商品列表
#define API_EMPLOYEE_MYSTORE_LAUD         ([NSString stringWithFormat:@"%@employee/mystore/laud", API_VERSION])
#define API_EMPLOYEE_FANS_GOODS           ([NSString stringWithFormat:@"%@employee/fans/goods", API_VERSION])                   /* 赞和我的商品列表 */
#define API_GOODS_DETAIL                  ([NSString stringWithFormat:@"%@goods/info", API_VERSION])                                    /* 根据bu_goods_id获取商品详情 */

#define API_SUBSCRIBE_STATUS              ([NSString stringWithFormat:@"%@subscribe/status", API_VERSION])                          /* 查询是否订阅 */
#define API_SUBSCRIBE_SUB                 ([NSString stringWithFormat:@"%@subscribe", API_VERSION])                                         /* 订阅 */
#define API_SUBSCRIBE_UN                  ([NSString stringWithFormat:@"%@unsubscribe", API_VERSION])                                       /* 退订 */
#define API_CART_STORE_LIST               ([NSString stringWithFormat:@"%@cart/store/list", API_VERSION])                               /*购物车商铺列表*/
#define API_CART_GOODS_LIST               ([NSString stringWithFormat:@"%@cart/goods/list", API_VERSION])                               /*购物车商品列表*/
#define API_CART_UPDATE_LIST              ([NSString stringWithFormat:@"%@cart/update", API_VERSION])                                   /*购物车商品更新*/
#define API_CART_GOODS_TOTAL              ([NSString stringWithFormat:@"%@cart/goods/total", API_VERSION])                          /*购物车商品总数*/

#define API_WTS_SETTINGS                  ([NSString stringWithFormat:@"%@user/settings/notification", API_VERSION])            /* 微通社设置提交 */
#define API_WTS_SYSTEM_MESSAGE_LIST       ([NSString stringWithFormat:@"%@user/message", API_VERSION])                                      /* 微通社系统消息 */
#define API_FEED_BACK_API                 ([NSString stringWithFormat:@"%@feedback", API_VERSION])                                              /* 用户反馈 */
#define API_VERSION_API                   ([NSString stringWithFormat:@"%@version", API_VERSION])                                               /* 软件版本 */
#define API_CHECK_VERIFY_CODE_API         ([NSString stringWithFormat:@"%@check/captcha", API_VERSION])                                 /* 审核验证码 */
#define API_TWO_SCAN_USER                 ([NSString stringWithFormat:@"%@user/invite", API_VERSION])                                       /* 二维码扫描用户和店员 */
#define API_RETURN_GOOD_API               ([NSString stringWithFormat:@"%@order/return_goods", API_VERSION])
#define API_GET_RETURN_GOOD_API           ([NSString stringWithFormat:@"%@order/get_return_goods", API_VERSION])


#pragma mark ============================== 朋友模块
#define API_USER_SEARCH                     ([NSString stringWithFormat:@"%@user/search", API_VERSION])                                     /* 根据手机号和微店号搜索用户 */
#define API_FRIEND_ANALYSE_API              ([NSString stringWithFormat:@"%@friend/addressbook/analyse", API_VERSION])      /*分析通讯录接口*/
//#define API_FRIEND_ANALYSE_API              ([NSString stringWithFormat:@"%@friend/address/analyse", API_VERSION])   /*分析通讯录接口*/
#define API_FRIEND_ADD_API                  ([NSString stringWithFormat:@"%@friend/add", API_VERSION])                          /*添加好友接口*/
#define API_FRIEND_LIST_API                 ([NSString stringWithFormat:@"%@friend/list", API_VERSION])
#define API_FRIEND_DELETE_API               ([NSString stringWithFormat:@"%@friend/delete", API_VERSION])
#define API_FRIEND_SEARCH_API               ([NSString stringWithFormat:@"%@friend/search", API_VERSION])
#define API_FRIEND_MESSAGECOUNT_API         ([NSString stringWithFormat:@"%@friend/message/count", API_VERSION])
#define API_FRIEND_MESSAGELIST_API          ([NSString stringWithFormat:@"%@friend/message/list", API_VERSION])
#define API_FRIEND_MESSAGEAGREE_API         ([NSString stringWithFormat:@"%@friend/message/agree", API_VERSION])
#define API_FRIEND_MESSAGEDELETE_API        ([NSString stringWithFormat:@"%@friend/message/delete", API_VERSION])
#define API_FRIEND_JUDGE_API                ([NSString stringWithFormat:@"%@friend/judge", API_VERSION])                            /*判断是否是当前用户的好友*/
#define API_FRIEND_SWEEP_CODE_ADD_API       ([NSString stringWithFormat:@"%@friend/sweep_code_add", API_VERSION])
#define FRIEND_REMARK_API                   ([NSString stringWithFormat:@"%@friend/remark", API_VERSION])


#pragma mark ============================== 名片相关
#define API_FRIEND_USER_INFO_API            ([NSString stringWithFormat:@"%@friend/user/info", API_VERSION])
#define API_FRIEND_DELETE_API               ([NSString stringWithFormat:@"%@friend/delete", API_VERSION])

#pragma mark ============================== 会员卡和优惠券
#define API_CAPTCHA_CHECK             @"api/captcha/check/" /* 会员卡手机绑定获取验证码 */
#define API_CARD_AND_COUPON_ENTRY     @"api/user/home"   /* 会员卡和优惠券入口 */
#define API_VCARD_APPLY               @"api/vcard/apply" /* 申请会员卡 */
#define API_VCARD_CHECK_VALID         @"api/vcard/card_check"/* 检查绑定的会员卡号是否已经绑定或申请 */
#define API_VCARD_LIST                @"api/vcard/list"  /* 获取会员卡列表 */
#define API_VCARD_BIND                @"api/vcard/bind" /* 绑定会员卡 */
#define API_VCARD_DETAIL              @"api/vcard/detail"/* 会员卡详情 */
#define API_VCARD_UNBIND              @"api/vcard/relieve"/* 解绑会员卡 */
#define API_COUPON_LIST               @"api/coupon/list" /* 获取优惠券列表 */
#define API_COUPON_LIST_USE               ([NSString stringWithFormat:@"%@order/coupons", API_VERSION]) /* 获取优惠券列表 */

#define API_COUPON_INFO ([NSString stringWithFormat:@"%@coupon/info", API_VERSION])
#define API_COUPON_ACQUIRE ([NSString stringWithFormat:@"%@coupon/acquire", API_VERSION])

#define API_COUPON_DETAIL             @"api/coupon/detail" /* 获取优惠券详情 */
#define API_COUPON_DELETE             @"api/coupon/delete" /* 删除优惠券 */
#define API_BU_LIST                   @"api/bu/list"    /* 获取或搜索零售商列表 */
#define API_BU_INFO                   @"api/bu/info"     /* 获取或搜索零售商信息 */
#define API_BU_DETAIL_INFO            ([NSString stringWithFormat:@"%@unit/detail", API_VERSION])  /* 获取商户的详细信息 */

#pragma mark ============================== 购物清单模块
#define API_SHOPPING_ADD              @"api/shopping/add"     /* 增加或删除购物清单 */
#define API_SHOPPING_LIST_ADD         @"api/shopping/list/add" /* 在购物清单中增加或删除商品 */
#define API_SHOPPING_LIST             @"api/shopping/list"     /* 获取购物清单列表或详情 */

#pragma mark ============================== 购物车相关
#define API_ADDCART_GOODS                           ([NSString stringWithFormat:@"%@cart/add", API_VERSION])             //加入购物车
#define API_CART_GOODSLISET_API                     ([NSString stringWithFormat:@"%@cart/list", API_VERSION])            //获取购物车列表
#define API_DELETEGOODS_API                         ([NSString stringWithFormat:@"%@cart/del", API_VERSION])             //删除购物车中单件商品
#define API_UPDATETOTAL_API                         ([NSString stringWithFormat:@"%@cart/update", API_VERSION])    //修改购物车中商品数量
#define API_ORDER_GET_AMOUNT                        ([NSString stringWithFormat:@"%@order/get_fare", API_VERSION]) //获取各门店订单运费，显示给用户
#define API_CART_GOODS_NUM                          ([NSString stringWithFormat:@"%@cart/num", API_VERSION])          //购物车商品个数


#pragma mark ============================== 摇一摇相关
#define API_SHAKE                       ([NSString stringWithFormat:@"%@shake", API_VERSION])              //摇
#define API_SHAKE_LIST                  ([NSString stringWithFormat:@"%@shake/list", API_VERSION])         //获取可摇和摇到的列表
#define API_SHAKE_VERTIFY_CODE          ([NSString stringWithFormat:@"%@shake/verfiycode", API_VERSION])   //验证要到的优惠券二维码
#define API_SHAKE_CERTAIN               ([NSString stringWithFormat:@"%@shake/certain", API_VERSION])      //中奖信息确定
#define API_SHAKE_CANCEL                ([NSString stringWithFormat:@"%@shake/cancel/certain/prize", API_VERSION]) //取消中奖信息
#define API_SHAKE_ACTIVETYLIST          ([NSString stringWithFormat:@"%@shake/activityList", API_VERSION])   //摇一摇活动列表

#pragma mark ============================== push 接口
#define API_ADD_Token               ([NSString stringWithFormat:@"%@user/add/token", API_VERSION])
#define API_PUSH_MESSAGE            ([NSString stringWithFormat:@"%@user/push/message", API_VERSION])
#define API_Goods_Url               ([NSString stringWithFormat:@"%@goods/url", API_VERSION])

#pragma mark ============================== 订单相关
#define API_GOODS_ATTR              ([NSString stringWithFormat:@"%@goods/attr", API_VERSION])
#define API_ORDER_SUBMIT_NEW        ([NSString stringWithFormat:@"%@order/new", API_VERSION])
#define API_MYORDERLIST_API         ([NSString stringWithFormat:@"%@order/list", API_VERSION])    //获取我的订单列表
#define API_RETURNLIST              ([NSString stringWithFormat:@"%@order/return_goods_list", API_VERSION])    //获取我的订单列表
//订单结算
#define API_ORDER_SETTLEMENT        ([NSString stringWithFormat:@"%@order/settlement", API_VERSION])
#define API_ORDER_PAYACTION         ([NSString stringWithFormat:@"%@order/get_pay", API_VERSION])
#define API_BUY_PLATFORM_CANCELORDER    ([NSString stringWithFormat:@"%@order/cancel_order", API_VERSION])    // 取消订单

#define API_BUY_PLATFORM_FINISHORDER ([NSString stringWithFormat:@"%@order/finish", API_VERSION])
#define API_BUY_PLATFORM_ORDERPAY_API   ([NSString stringWithFormat:@"%@order/pay", API_VERSION])               // 支付订单
#define API_GET_ORDER_INFO              ([NSString stringWithFormat:@"%@order/order_info", API_VERSION])    //订单详情
//订单地址相关
#define API_ORDER_ADDRESS_LIST          ([NSString stringWithFormat:@"%@order/address/list", API_VERSION])       //地址列表
#define API_ORDER_ADDRESS_ADD           ([NSString stringWithFormat:@"%@order/address/add", API_VERSION])        //添加新地址
#define API_ORDER_ADDRESS_UPDATE        ([NSString stringWithFormat:@"%@order/address/update", API_VERSION])     //更新地址
#define API_ORDER_ADDRESS_DELETE        ([NSString stringWithFormat:@"%@order/address/del", API_VERSION])     //删除地址
#define API_ORDER_ADDRESS_SET           ([NSString stringWithFormat:@"%@order/address/set", API_VERSION])        //设置默认地址
#define API_ORDER_AREA_LIST             @"area/list"        //省市区列表
#define API_ORDER_REGION_GET             ([NSString stringWithFormat:@"%@region/get", API_VERSION])          //**省市区列表

#define API_ORDER_ADDRESS_GET ([NSString stringWithFormat:@"%@order/address/get", API_VERSION])     //获取默认地址

#pragma mark ============================== 品类品牌相关
#define API_BU_CATEGORY_LIST              ([NSString stringWithFormat:@"%@bu/categorys/list", API_VERSION])    //门店下的品类列表
//#define API_CATEGORY_CHILD_LIST           ([NSString stringWithFormat:@"%@bu/last/category/list", API_VERSION]) //品类下的子品类列表
#define API_CATEGORY_CHILD_LIST           ([NSString stringWithFormat:@"%@bu/categorys/next", API_VERSION]) //品类下的子品类列表
#define API_BU_BRAND_LIST                 ([NSString stringWithFormat:@"%@bu/brands/list", API_VERSION])       //门店下的品牌列表

#pragma mark ============================== 我的微店订阅部分
#define API_MY_STORE_ORDER_LIST           ([NSString stringWithFormat:@"%@mystore/subscribes", API_VERSION])  //我订阅的门店,品牌，商品，活动
#define API_MY_STORE_ORDER_OTHER_LIST     ([NSString stringWithFormat:@"%@mystore/subscribes_other", API_VERSION])//我订阅的别人的商品，活动

#pragma mark ============================== 微通社新接口v2.0
#define API_WTS_MESSAGE_LIST              ([NSString stringWithFormat:@"%@dynamic/list", API_VERSION])        //微通社的消息列表
#define API_WTS_MESSAGE_LIST_V2           ([NSString stringWithFormat:@"%@dynamic/recommend", API_VERSION])   //微通社的推荐消息列表
#define API_WTS_MESSAGE_DETAIL            ([NSString stringWithFormat:@"%@dynamic/info", API_VERSION])        //微通社详情
#define API_WTS_MESSAGE_COMMENT_LIST_V2   ([NSString stringWithFormat:@"%@dynamic/commentList", API_VERSION]) //微通社的消息的评论列表
#define API_WTS_MESSAGE_LUASUSER_LIST_V2  ([NSString stringWithFormat:@"%@dynamic/laudUserList", API_VERSION])//微通社的消息的赞的用户列表
#define API_WTS_MESSAGE_LAUD_V2           ([NSString stringWithFormat:@"%@dynamic/laud", API_VERSION])        //赞微通社消息
#define API_WTS_MESSAGE_COMMENT_V2        ([NSString stringWithFormat:@"%@dynamic/comment", API_VERSION])     //商品评论
#define API_WTS_MESSAGE_LAUD_STATUS_V2    ([NSString stringWithFormat:@"%@dynamic/checkLaud", API_VERSION])   //微通社消息赞的状态

#pragma mark ============================== 第三方分享统计
#define API_SHARE_TONGJI                  ([NSString stringWithFormat:@"%@share/statistics", API_VERSION])    //第三方分享统计

#pragma mark ============================== 第三方分享内容
#define API_SHARE                          ([NSString stringWithFormat:@"%@share", API_VERSION])
#define API_SHARE_WTS                          ([NSString stringWithFormat:@"%@share/todynamic", API_VERSION])

#pragma mark ============================== 微店首页模块
#define API_HOME_PAGE                ([NSString stringWithFormat:@"%@home", API_VERSION])               //微店首页
#define API_ALL_STORE_LIST           ([NSString stringWithFormat:@"%@unit/storeList", API_VERSION])      //全部商户列表
#define API_ALL_STORE_LIST_GET           ([NSString stringWithFormat:@"%@coupon/more", API_VERSION])      //优惠达人->更多门店

#define API_ALL_STORE_COUPON_GET           ([NSString stringWithFormat:@"%@coupon/store_list", API_VERSION])      //适用商户列表

#define API_ALL_EMPLOYEES_LIST_GET           ([NSString stringWithFormat:@"%@coupon/employees", API_VERSION])      //全部店员

#define API_ALL_STORE_DUSTRY_LIST    ([NSString stringWithFormat:@"%@unit/industryList", API_VERSION])  //全部商户的业态
#define API_ALL_MORE_SHAKE_LIST      ([NSString stringWithFormat:@"%@home/shake/more", API_VERSION])       //首页更多摇一摇
#define API_ALL_MORE_GOODS_LIST      ([NSString stringWithFormat:@"%@home/goods/more", API_VERSION])       //首页更多商品
#pragma mark ============================== 根据商品id获取店员信息，和店员聊天
#define API_IM_EMPLOYEE_INFO_V222         ([NSString stringWithFormat:@"%@goods/employee_info", API_VERSION]) //获取IM店员，可以聊天的


#define API_APP_ISLOGIN_AND_JUMP           ([NSString stringWithFormat:@"%@jump/config", API_VERSION])         //判断用户是否登录，并获取要跳转的页面
#define API_APP_GYG_JUMP_URL               ([NSString stringWithFormat:@"%@jump/url", API_VERSION])            //获取逛一逛跳转的页面
#define API_APP_GYG_RELATED_STORES         ([NSString stringWithFormat:@"%@unit/getCount", API_VERSION])       //获取门店的相关门店
#define API_APP_LOCATION_STORE_LIST        ([NSString stringWithFormat:@"%@store/list", API_VERSION])          //某tag下的商店list

#define API_CUS_COUPON_HAVE_NEWS           ([NSString stringWithFormat:@"%@coupon/coupon_count", API_VERSION])      //是否有新券
#define API_CUS_CARD_HAVE_NEWS             @"api/vcard/card_read"         //是否有新卡

#define API_CUS_PREFERENTIAL_LIST          ([NSString stringWithFormat:@"%@preferential", API_VERSION])            //优惠频道
#define API_CUS_ALLCOUPON_LIST          ([NSString stringWithFormat:@"%@coupon/more_coupon", API_VERSION])   //更多优惠

#define API_QUERY_ORDER  ([NSString stringWithFormat:@"%@order_quick/query_order", API_VERSION])

#define API_CANCEL_ORDER  ([NSString stringWithFormat:@"%@order_quick/cancel_orders", API_VERSION])

#define API_IS_PAY_SUCCESS  ([NSString stringWithFormat:@"%@order_quick/is_pay_success", API_VERSION])

#define API_QUICK_ORDER_LIST  ([NSString stringWithFormat:@"%@order_quick/quick_order_list", API_VERSION])
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



@end



