//
//  Utility.m
//  myappone
//
//  Created by wbw on 12-11-23.
//  Copyright (c) 2012年 ChangShengTianDi std. All rights reserved.
//

#import "Utility.h"
#import "MACROS_P.h"
//#import "UserDetailInfoEntity.h"
#import "GTMBase64_WD.h"
//#import "LocationManager.h"
#import "BMKGeometry.h"
@implementation LocationEntity

@synthesize bd_lat;
@synthesize bd_lon;
@synthesize gg_lat;
@synthesize gg_lon;

@end

@implementation Utility
{
//    SuccessBlock successBlock_;
//    FailedBlock  failedBlock_;

}

//@synthesize successBlock_;
//@synthesize failedBlock_;
+(Utility *)allocwithInit
{
    static Utility *utiliey;
    @synchronized(self) {
        if(!utiliey) {
            utiliey = [[Utility alloc] init];
            
            
        }
    }
    
    return utiliey;
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
 * @brief 验证身份证号码的合法性
 */
const int factor[] = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };//加权因子
const int checktable[] = { 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 };//校验值对应表

-(BOOL)checkIDfromchar:(char *)ID
{
    if (strlen(ID)!=18) {//验证18位
        return 0;
    }
    int IDNumber[ 19 ];
    for ( int i = 0; i < 18; i ++ )//相当于类型转换
        IDNumber[ i ] = ID[ i ] - 48;
    return [self checkID:IDNumber Id:ID];
}

/**
 * @brief 
 */
-(BOOL)checkID:(int*)IDNumber Id:(char*)ID
{
    int i = 0;//i为计数
    int checksum = 0;
    for ( ; i < 17; i ++ )
        checksum += IDNumber[ i ] * factor[ i ];
    
    if ( IDNumber[ 17 ] == checktable[ checksum % 11 ] || ( ID[ 17 ] == 'x' && checktable[ checksum % 11 ] == 10 )||( ID[ 17 ] == 'X' && checktable[ checksum % 11 ] == 10 ))
        return 1;
    else
        return 0;
}

/***
 * @brief 会员卡颜色值对应背景image
 */
-(NSString *)cardImgName:(NSInteger)colorIndex
{
    NSArray *bgImgArray = [NSArray arrayWithObjects:@"bg_red.png", @"bg_yellow.png", @"bg_gray.png", @"bg_khaki.png", @"bg_blue.png", @"bg_green.png", @"bg_purple.png", @"bg_brown.png", nil];
    if (colorIndex >= bgImgArray.count || colorIndex < 0) {
        /* 如果颜色代码超出界线个数，则设置默认值 */
        return @"bg_red.png";
    }
    return [bgImgArray objectAtIndex:colorIndex];
}

/***
 * @brief 手机号有效性检查
 */
- (BOOL)isMobileNumber:(NSString *)mobileNum
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


-(LocationEntity*)gg_to_bd:(double)gg_lat  GG_lon:(double)gg_lon
{/*
    double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    double bd_lon = z * cos(theta) + 0.0065;
    double bd_lat = z * sin(theta) + 0.006;
    LocationEntity *entity = [[LocationEntity alloc] init];
    entity.bd_lon = bd_lon;
    entity.bd_lat = bd_lat;*/
    CLLocationCoordinate2D test = CLLocationCoordinate2DMake(gg_lat, gg_lon);
    //转换 google地图、soso地图、aliyun地图、mapabc地图和amap地图所用坐标至百度坐标
    NSDictionary* testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_COMMON);
    //转换GPS坐标至百度坐标
    testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_GPS);
    NSString* strX = [testdic objectForKey:@"x"];
    NSString* strY = [testdic objectForKey:@"y"];
    
    NSData *xdata = [GTMBase64_WD decodeString:strX];
    NSData *ydata = [GTMBase64_WD decodeString:strY];
    NSString *xstr = [[NSString alloc] initWithData:xdata encoding:NSUTF8StringEncoding];
    NSString *ystr = [[NSString alloc] initWithData:ydata encoding:NSUTF8StringEncoding];
    CLLocationCoordinate2D result;
    result.latitude =[ystr floatValue];
    result.longitude = [xstr floatValue];
    LocationEntity *entity = [[LocationEntity alloc] init];
    entity.bd_lon = result.longitude;
    entity.bd_lat = result.latitude;
    return entity;
}

-(LocationEntity*)bd_to_gg:(double)bd_lat  BD_lon:(double)bd_lon
{
    double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    double gg_lon = z * cos(theta);
    double gg_lat = z * sin(theta);
    
    LocationEntity *entity = [[LocationEntity alloc] init];
    entity.gg_lon = gg_lon;
    entity.gg_lat = gg_lat;
    
    return entity;
}

@end
