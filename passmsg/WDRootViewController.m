//
//  RootViewController.m
//  
//
//  Created by lichentao on 13-8-5.
//  Copyright (c) 2013年 efuture. All rights reserved.
//

#import "WDRootViewController.h"
#import "Reachability.h"
@interface WDRootViewController ()

@end

@implementation WDRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[UIApplication sharedApplication]
         setApplicationSupportsShakeToEdit:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)showAlert:(NSString *)message{
    
    [self showAlert:nil Message:message];
}

- (void)showAlert:(id)target Message:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message
                                               delegate:target cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)showNotice:(NSString *)string{
    [[iToast makeText:string] show];
}

- (BOOL)checkNetreachability{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reachability currentReachabilityStatus];
    if (status == NotReachable) {
        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
