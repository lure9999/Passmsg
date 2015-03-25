//
//  ManuleViewController.m
//  base
//
//  Created by ioswang on 13-10-8.
//  Copyright (c) 2013年 wbw. All rights reserved.
//
//  新用户第一次登陆，显示小白手册，引导用户

#import "ManuleViewController.h"


@interface ManuleViewController ()

@end

@implementation ManuleViewController
@synthesize _scrollView;
//@synthesize _pageControl;

#pragma mark --------------------------初始化
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark --------------------------声明周期
-(void)loadView
{
    [super loadView];
    [self addScrollView];
    [self addPageControl];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark ------------------------- 添加view
-(void)addScrollView
{
    //scroll view包含小白手册
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height);
    [scrollView setPagingEnabled:YES];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    
    
    ///小白手册第一页
    UIImage *img1 = [UIImage imageNamed:@"welcome_1.png"];
    UIImageView *imgV1 = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-img1.size.width)/2, (self.view.frame.size.height-img1.size.height)/2, img1.size.width, img1.size.height)];
    [imgV1 setImage:img1];
    [scrollView addSubview:imgV1];
    
    ///小白手册第二页
    UIImage *img2 = [UIImage imageNamed:@"welcome_2.png"];
    UIImageView *imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width+(self.view.frame.size.width-img2.size.width)/2, (self.view.frame.size.height-img2.size.height)/2, img2.size.width, img2.size.height)];
    [imgV2 setImage:img2];
    [scrollView addSubview:imgV2];
    
    ///小白手册第三页
    UIImage *img3 = [UIImage imageNamed:@"welcome_3.png"];
    UIImageView *imgV3 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2+(self.view.frame.size.width-img3.size.width)/2, (self.view.frame.size.height-img3.size.height)/2, img3.size.width, img3.size.height)];
    imgV3.userInteractionEnabled = YES;
    [imgV3 setImage:img3];
    [scrollView addSubview:imgV3];
    
    ////第三页的跳转按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width, self.view.frame.size.height);
    [btn addTarget:self action:@selector(skipButtonClickEventHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn];
    
    
    self._scrollView = scrollView;
    [self.view addSubview:scrollView];
}
/*
 * @brief  添加翻页指示器
 */
-(void)addPageControl
{
//    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 20)];
//    
//    pageControl.backgroundColor = [UIColor clearColor];
//    pageControl.currentPage = 0;
//    pageControl.numberOfPages = 3;
//    self._pageControl = pageControl;
//    [self.view addSubview:pageControl];
    
}
#pragma mark ------------------------- UIButton事件处理
-(void)skipButtonClickEventHandler:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
#pragma mark ------------------------- UIScrollview Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //CGPoint point = scrollView.contentOffset;
    //[self._pageControl setCurrentPage:point.x/self.view.frame.size.width];
    
    if (scrollView.contentOffset.x > self.view.frame.size.width*2+30) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
@end
