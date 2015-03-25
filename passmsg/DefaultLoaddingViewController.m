//
//  DefaultLoaddingViewController.m
//  mystoreCustomer
//
//  Created by ioswang on 14-5-12.
//  Copyright (c) 2014年 ChangShengTianDi std. All rights reserved.
//
//  加载tabbar之前的view controller


#import "DefaultLoaddingViewController.h"
#import "Reachability.h"



@interface DefaultLoaddingViewController ()
@property (nonatomic, strong) UIButton *_btnRetry;
@end

@implementation DefaultLoaddingViewController
@synthesize _btnRetry;


#pragma mark ============================= 初始化
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark ============================= 生命周期
-(void)loadView
{
    [super loadView];
    [self addBackgroundView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [super viewWillDisappear:animated];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
#pragma mark =============================  添加view
/* 添加背景 */
-(void)addBackgroundView
{
    //背景
    UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (SCREEN_HEIGHT == 568) {
        [imagev setImage:[UIImage imageNamed:@"Default-568h.png"]];
    }else
    {
        [imagev setImage:[UIImage imageNamed:@"Default.png"]];
    }
    [self.view addSubview:imagev];
}
#pragma mark =============================  UIButton事件处理


#pragma mark =============================  替换rootviewcontroller

@end