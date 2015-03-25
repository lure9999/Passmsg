//
//  RootViewController.h
//  //WeiDian
//
//  Created by lichentao on 13-8-5.
//  Copyright (c) 2013年 efuture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDRootViewController : UIViewController<UIAlertViewDelegate>{

    float originY;
}

- (void)showAlert:(NSString *)message;
- (void)showAlert:(id)target Message:(NSString *)message;
- (void)showNotice:(NSString *)string;

- (BOOL)checkNetreachability;
@end
