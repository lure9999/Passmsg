//
//  RDVDetailsViewController.m
//  RDVTabBarController
//
//  Created by Robert Dimitrov on 11/8/14.
//  Copyright (c) 2014 Robert Dimitrov. All rights reserved.
//

#import "RDVDetailsViewController.h"

@interface RDVDetailsViewController ()

@end

@implementation RDVDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Details";
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Detail View Controller";
    label.frame = CGRectMake(20, 150, CGRectGetWidth(self.view.frame) - 2 * 20, 20);
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

- (void)viewWillDisappear:(BOOL)animated {
 
    
    [super viewWillDisappear:animated];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
