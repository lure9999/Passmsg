//
//  Utility.h
//  myappone
//
//  Created by wbw on 12-11-23.
//  Copyright (c) 2012年 ChangShengTianDi std. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void (^SuccessBlock)(void);//定义块类型SuccessBlock: 网络连接获取数据成功时的回调
//typedef void (^FailedBlock)(void);//定义块类型EditBeginBlcok: 网络连接失败时的回调


@interface LocationEntity : NSObject
{
    double bd_lon;
    double bd_lat;
    double gg_lon;
    double gg_lat;
}
@property (nonatomic, assign) double bd_lon;
@property (nonatomic, assign) double bd_lat;
@property (nonatomic, assign) double gg_lon;
@property (nonatomic, assign) double gg_lat;
@end

@interface Utility : NSObject
//@property (nonatomic, copy)     SuccessBlock successBlock_;
//@property (nonatomic, copy)     FailedBlock  failedBlock_;

+(Utility *)allocwithInit;
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
//- (BOOL)isLogin:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock;



/***
 * @brief 验证身份证号码的合法性
 */
-(BOOL)checkIDfromchar:(char *)ID;

/***
 * @brief 会员卡颜色值对应背景image
 */
-(NSString *)cardImgName:(NSInteger)colorIndex;

/***
 * @brief 手机号有效性检查
 */
- (BOOL)isMobileNumber:(NSString *)mobileNum;

/***
关于 GCJ-02 和 BD-09 ，请参考 http://developer.baidu.com/map/question.htm#qa0043 。
算法代码如下，其中 bd_encrypt 将 GCJ-02 坐标转换成 BD-09 坐标， bd_decrypt 反之。
[cpp] view plaincopyprint?
*/

-(LocationEntity*)gg_to_bd:(double)gg_lat  GG_lon:(double)gg_lon;
-(LocationEntity*)bd_to_gg:(double)bd_lat  BD_lon:(double)bd_lon;

@end
