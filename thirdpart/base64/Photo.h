#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
@interface NSData (MBBase64)

+ (id)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64Encoding;

@end
@interface Photo : NSObject {
	
}
+ (NSString *)imageData2String:(NSData *)pictureData;
/*
 * 图片转换为字符串
 */
+ (NSString *) image2String:(UIImage *)image;

/*
 * 字符串转换为图片
 */
+ (UIImage *) string2Image:(NSString *)string;

@end