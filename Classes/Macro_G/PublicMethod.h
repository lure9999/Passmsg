//
//  PublicMethod.h
//  SuNingCustomer
//
//  Created by wangbob on 13-7-22.
//  Copyright (c) 2013年 SuNing. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    AlixPayType_Faster = 0,  // 快捷支付
    AlixPayType_Web          // web支付
} PayType;

@interface PublicMethod : NSObject

+(UIButton*) backButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage;
+(void) addBackButtonWithTarget:(UIViewController *)viewController action:(SEL)action;
/**
 * 生成导航条背景
 */
+(void)addNavBackground:(UIView *)view title:(NSString *)title;
//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

//保存图片
+ (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;


+ (NSString *)documentFolderPath;

+ (BOOL) validateNickname:(NSString *)nickname;
/***
 * @brief 手机号有效性检查
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  @brief 检查字符串是否是数字
 */
+ (BOOL) validateNumber:(NSString *)number;

/***
 * @brief 密码有效性检查
 */
+ (BOOL)isPassword:(NSString *)password;
/*加载状态*/
+(void)ShowWaitingView:(BOOL)isShow;

+ (UILabel *)addLabel:(CGRect)rect setTitle:(NSString *)title setBackColor:(UIColor *)color setFont:(UIFont *)font;
+ (UIImageView *)addImageView:(CGRect)rect setImage:(NSString *)imageString;
+ (UIView *)addBackView:(CGRect)rect setBackColor:(UIColor *)color;
+ (UIButton *)addButton:(CGRect)rect title:(NSString *)title backGround:(NSString *)imgString setTag:(NSInteger)tag setId:(id)_sel selector:(SEL)selector setFont:(UIFont *)font setTextColor:(UIColor *)color;
//通过十六进制和alpha生成颜色
+ (UIColor*)colorWithHexValue:(NSInteger)aHexValue
                        alpha:(CGFloat)aAlpha;

// 调用支付宝 订单参数＋支付方式
+ (void)AlixPayWithParams:(id)_sel OrderStr:(NSString *)orderStr WithType:(PayType)payStyle fromtype:(int)fromtype;

//颜色生成图片
+ (UIImage *)createImageWithColor:(UIColor *)color imageRect:(CGRect)rect;

//md5编码
+ (NSString *)md5string:(NSString *)str;

/**
 *  检查string是否为整数
 *
 *  @param string
 *
 *  @return 
 */
+ (BOOL)isPureInt:(NSString*)string;
+ (NSString *)getIPAddress;
@end
