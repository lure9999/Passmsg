//
//  EXRootViewController.h
//  mystoreCustomer
//
//  Created by ioswang on 14-2-19.
//  Copyright (c) 2014年 ChangShengTianDi std. All rights reserved.
//
//  友盟跟controller,用来统计界面展示次数


#import <UIKit/UIKit.h>


@interface EXRootViewController : UIViewController
{
    
}

@end

@interface WebExRootViewController:EXRootViewController<UIWebViewDelegate>
{
    UIWebView       *_webView;
}
@property (nonatomic, strong)NSURLConnection* _urlConnection;
@property (nonatomic, assign) BOOL _authenticated;
@property (nonatomic, strong) UIWebView       *_webView;
@property (nonatomic, strong)NSURLRequest* _request;
@end