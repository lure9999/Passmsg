//
//  PaySDKTypeDef.h
//  mystoreCustomer
//
//  Created by Liu Zhichao on 14-12-25.
//  Copyright (c) 2014年 ChangShengTianDi std. All rights reserved.
//

#ifndef mystoreCustomer_PaySDKTypeDef_h
#define mystoreCustomer_PaySDKTypeDef_h
typedef enum
{
    PaySDKTypeAlipay = 1,         /**< 支付宝 */
    PaySDKTypeAlipayWap = 2,      /**< 支付宝网页 */
    PaySDKTypeBaiduWap = 3,         /**< 百度网页 */
    PaySDKTypeWeiXin = 4,          /**< 微信 */
    PaySDKTypeUppay = 5,            /**< 银联 */
  
}PaySDKType;
#endif
