//
//  PublicMethod.m
//  SuNingCustomer
//
//  Created by wangbob on 13-7-22.
//  Copyright (c) 2013年 SuNing. All rights reserved.
//

#import "PublicMethod.h"
#import "AlixPay.h"
#import "MACROS_P.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>


#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation PublicMethod

/**
 *@   生成导航条上的按钮
 */
+(UIButton*) backButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage
{
    // Create a custom button
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Make the button as high as the passed in image
    button.frame = CGRectMake(0, 0, 35, 29);
    
    // Set the stretchable images as the background for the button
    [button setImage:backButtonImage forState:UIControlStateNormal];
    [button setImage:backButtonHighlightImage forState:UIControlStateHighlighted];
    
    return button;
}

/**
 *@   生成导航条上的按钮
 */
+(void) addBackButtonWithTarget:(UIViewController *)viewController action:(SEL)action
{
    float originY = 0.f;
    if (IOS_VERSION >= 7) {
        originY = 20.f;
    }
    /*返回按钮*/
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(6, 7+originY, 40, 30);
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    //[backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateHighlighted];
    backBtn.contentMode = UIViewContentModeCenter;
    [backBtn addTarget:viewController action:action forControlEvents:UIControlEventTouchUpInside];
    [viewController.view addSubview:backBtn];
}

/**
 * 生成导航条背景
 */
+(void)addNavBackground:(UIView *)view title:(NSString *)title
{
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_bg.png"]];
    float originY = 0.f;
    if (IOS_VERSION >= 7) {
        originY = 20.f;
    }
    bgView.frame = CGRectMake(0, originY, SCREEN_WIDTH, NAVBAR_HEIGHT);
    [view addSubview:bgView];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, 320, NAVBAR_HEIGHT)];
    titleLbl.text = title;
    titleLbl.backgroundColor = [UIColor clearColor];
    titleLbl.textColor = RGBCOLOR(255, 80, 0);
    titleLbl.font = [UIFont boldSystemFontOfSize:20];
    [titleLbl setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:titleLbl];
    
}

//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

#pragma mark 保存图片到document
+ (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImageJPEGRepresentation(tempImage, 1.0);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}
#pragma mark 从文档目录下获取Documents路径
+ (NSString *)documentFolderPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

/***
 * @brief 手机号有效性检查
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     移动号段：134、135、136、137、138、139、147、150、151、152、157、158、159、182、 183、184、187、188
     联通号段：130、131、132、155、156、185、186、145
     电信号段：133、153、180、181、189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-9]|4[57])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{1,4}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nicknameRegex];
    BOOL isMatch = [pred evaluateWithObject:nickname];
    return isMatch;

}

+ (BOOL) validateNumber:(NSString *)number
{
    NSString *numberRegex = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

/***
 * @brief 密码有效性检查
 */
+ (BOOL)isPassword:(NSString *)password
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[a-zA-Z0-9]{6,30}$" options:NSRegularExpressionCaseInsensitive error:nil];
    if (regex != nil) {
        NSUInteger numberOfMatch = [regex numberOfMatchesInString:password options:0 range:NSMakeRange(0, [password length])];
        if (numberOfMatch == 0) {
            return NO;
        }
    }
    return  YES;
    
}

/* 添加公共方法 */
static UIWindow *awindow;

+ (UIButton *)addButton:(CGRect)rect title:(NSString *)title backGround:(NSString *)imgString setTag:(NSInteger)tag setId:(id)_sel selector:(SEL)selector setFont:(UIFont *)font setTextColor:(UIColor *)color{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn setBackgroundImage:[UIImage imageNamed:imgString] forState:UIControlStateNormal];
    [btn setTag:tag];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:_sel action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIView *)addBackView:(CGRect)rect setBackColor:(UIColor *)color{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = color;
    return view;
}

+ (UIImageView *)addImageView:(CGRect)rect setImage:(NSString *)imageString{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
//    [imageView setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:nil];
    imageView.image = [UIImage imageNamed:imageString];
    return imageView;
}

+ (UILabel *)addLabel:(CGRect)rect setTitle:(NSString *)title setBackColor:(UIColor *)color setFont:(UIFont *)font{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.autoresizingMask = YES;
    label.text = title;
    label.numberOfLines = 0;
    label.font = font;
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    return label;
}

/* 加载状态 */
+(void)ShowWaitingView:(BOOL)isShow
{
    if (isShow)
    {
        if (!awindow)
        {
            awindow=[[UIWindow alloc] initWithFrame:CGRectMake(0, 20, 320, [UIScreen mainScreen].bounds.size.height)];
            awindow.windowLevel=UIWindowLevelStatusBar;
        }
        [MBProgressHUD hideHUDForView:awindow animated:YES];
        [MBProgressHUD showHUDAddedTo:awindow animated:YES];
        [awindow makeKeyAndVisible];
    }
    else{
        if (awindow) {
            [awindow resignKeyWindow];
            [awindow setHidden:YES];
            [MBProgressHUD hideHUDForView:awindow animated:YES];
        }
    }
}

//通过十六进制和alpha生成颜色
+ (UIColor*)colorWithHexValue:(NSInteger)aHexValue
                        alpha:(CGFloat)aAlpha {
    
	return [UIColor colorWithRed:((CGFloat)((aHexValue&0xFF0000)>>16))/255.0
						   green:((CGFloat)((aHexValue&0xFF00)>>8))/255.0
							blue:((CGFloat)(aHexValue&0xFF))/255.0
						   alpha:aAlpha];
    
}

+ (void)AlixPayWithParams:(id)_sel OrderStr:(NSString *)orderStr WithType:(PayType)payStyle fromtype:(int)fromtype{
    
    NSLog(@"key:%@",orderStr);
    
   
    
    if (payStyle == AlixPayType_Faster) {
        //获取快捷支付单例并调用快捷支付接口
        AlixPay * alixpay = [AlixPay shared];
        int ret = [alixpay pay:orderStr applicationScheme:@"myappone"];
        
        if (ret == kSPErrorAlipayClientNotInstalled) {
            
            AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            appDelegate._isFromAlipay = 0;
            
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:@"您还没有安装支付宝快捷支付，请先安装。"
                                                                delegate:_sel
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:nil];
            [alertView setTag:123];
            [alertView show];
        }
        else if (ret == kSPErrorSignError) {
            NSLog(@"签名错误！");
        }else{
            AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            appDelegate._isFromAlipay = fromtype;
        }
    }
    
}
/*
 * 颜色转换为image
 */
+ (UIImage *)createImageWithColor:(UIColor *)color imageRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
+ (NSString *)md5string:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}



+ (NSString *)getIPAddress
{
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

@end
