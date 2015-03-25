//
//  UIImageView+CardImageView.h
//  myappone
//
//  Created by liuyao on 13-4-27.
//  Copyright (c) 2013年 ChangShengTianDi std. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CardImageView)
- (void) setImage:(UIImage *)image
     withCardName:(NSString *)cardName
      withCardNum:(NSString *)cardNum;
@end
