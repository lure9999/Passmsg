//
//  TabFourVC.m
//  passmsg
//
//  Created by Liu Zhichao on 15-3-26.
//  Copyright (c) 2015年 LiuZhiChao. All rights reserved.
//

#import "TabFourVC.h"

@interface TabFourVC ()

@end

@implementation TabFourVC
#pragma mark -tab nav 

-(void)addNavAndTabItem
{
    self.tabBarItem.title = @"TAB-4";
    
    UIImage *img_p =[[UIImage imageNamed:@"tabbar_gyg_p.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *img = [[UIImage imageNamed:@"tabbar_gyg.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [self.tabBarItem setFinishedSelectedImage:img_p withFinishedUnselectedImage:img];
    [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
 
    /* NAV右侧按钮 */
    UIButton *setb = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [setb setImage:[UIImage imageNamed:@"navigation_setting.png"] forState:UIControlStateNormal];
    [setb setImage:[UIImage imageNamed:@"navigation_setting_p.png"] forState:UIControlStateHighlighted];
    //[setb addTarget:self action:@selector(buttonSettingEventHandler) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barbuttonset = [[UIBarButtonItem alloc]initWithCustomView:setb];
    self.navigationItem.rightBarButtonItem = barbuttonset;
}



#pragma mark -init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
        if(IOS_VERSION>=7.0) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        self.title = @"TAB-4";
        self.view.backgroundColor = [UIColor blueColor];
       
    }
    return self;
}
-(void)loadView{
    [super loadView];
    [self addNavAndTabItem];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
