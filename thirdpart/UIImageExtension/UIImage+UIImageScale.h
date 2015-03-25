//
//  UIImage(UIImageScale).h
//  THCustomer
//
//  Created by efuture on 13-9-12.
//  Copyright (c) 2013年 efuture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(UIImageScale)
-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)newSize;
-(UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
