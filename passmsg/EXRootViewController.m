//
//  EXRootViewController.m
//  mystoreCustomer
//
//  Created by ioswang on 14-2-19.
//  Copyright (c) 2014年 ChangShengTianDi std. All rights reserved.
//
//  友盟跟controller,用来统计界面展示次数

#import "EXRootViewController.h"

@interface EXRootViewController ()

@end

@implementation EXRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self addBackButton];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@", [self class]]];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@", [self class]]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[ASIDownloadCache sharedCache] clearCachedResponsesForStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [[SDImageCache sharedImageCache] clearDisk];
}
-(void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    
}
-(void)addBackButton
{
    /* Back按钮 */
    UIButton *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    if (IOS_VERSION >= 7.0)
    {
        [backbtn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    }
    //backbtn.backgroundColor = [UIColor redColor];
    [backbtn setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backbtn setImage:[UIImage imageNamed:@"nav_back_p.png"] forState:UIControlStateHighlighted];
    [backbtn addTarget:self action:@selector(BackButtonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barbackbtn = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.navigationItem.leftBarButtonItem = barbackbtn;
}

-(void)BackButtonClickEvent:(id)sender
{
    
}

@end

@implementation WebExRootViewController

@synthesize _urlConnection,_authenticated,_webView,_request;

#pragma mark --------------------------webview delegate


#pragma mark - NURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
{
    NSLog(@"WebController Got auth challange via NSURLConnection");
    
    if ([challenge previousFailureCount] == 0)
    {
        _authenticated = YES;
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
     
    } else
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    NSLog(@"WebController received response via NSURLConnection");
    
    // remake a webview call now that authentication has passed ok.
    _authenticated = YES;
    
    [self._webView loadRequest:_request];
    
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    //[self.navigationItem setTitle:@"载入中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"webview load faild %@",error);
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if([[[[request URL] scheme] lowercaseString] isEqualToString:@"https"])
    {
        if (!_authenticated) {
            _authenticated = NO;
            self._request = request;
            self._urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            
            [_urlConnection start];
            
            return NO;
        }
    }
    
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"%@",requestString);
    
    NSString *decode =[requestString URLDecodeString];
    if ([decode rangeOfString:@"#myrainbowparams#"].location == NSNotFound)
    {
        return YES;
    }
    else
    {
        NSString *finalStr = [decode getJsonStrWithOutHttpBySeprateStr:@"#myrainbowparams#"];
        
        if (finalStr != nil) {
            NSDictionary *paramDic = [finalStr objectFromJSONString];
            NSString *actionid = [paramDic objectForKey:@"actionid"];
            
            if ([actionid isEqualToString:@"000"])
            {
//                //进入链接页面
//                [self setHidesBottomBarWhenPushed:YES];
//                NSDictionary* dicpara = [paramDic objectForKey:@"params"];
//                NSURL *url = [NSURL URLWithString:[dicpara objectForKey:@"url"]];
//                GYGCommonViewController *gygcVC = [[GYGCommonViewController alloc]init];
//                [gygcVC setParams_setUrl:url Title:nil];
//                [self.navigationController pushViewController:gygcVC animated:YES];
                return NO;
            }
            //进入活动详情
        
    }
    return YES;
}
}


@end