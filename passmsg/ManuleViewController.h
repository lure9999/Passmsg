//
//  ManuleViewController.h
//  base
//
//  Created by ioswang on 13-10-8.
//  Copyright (c) 2013年 wbw. All rights reserved.
//
//  新用户第一次登陆，显示小白手册，引导用户

#import <UIKit/UIKit.h>

@interface ManuleViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView   *_scrollView;
//@property (nonatomic, strong) UIPageControl  *_pageControl;

@end
