//
//  TabOneVC.m
//  passmsg
//
//  Created by Liu Zhichao on 15-3-26.
//  Copyright (c) 2015年 LiuZhiChao. All rights reserved.
//

#import "TabOneVC.h"
#import "MessageEntity.h"
enum
{
    
    TAG_STYLETWO_COUPON_BG = 1000,
    TAG_STYLETWO_COUPON_IMAGE,
    TAG_STYLETWO_COUPON_NAME,
    TAG_STYLETWO_COUPON_TIME,
    TAG_STYLETWO_COUPON_MONEY,
    TAG_STYLETWO_COUPON_STORE,
    
};
@interface TabOneVC ()
@property (nonatomic, strong) NSMutableArray                     *_arrData;
@property (nonatomic, assign) NSInteger                          _intPageIndex;
@end

@implementation TabOneVC

@synthesize  _tableView,_arrData,_intPageIndex;
#pragma mark -tab nav 

-(void)addNavAndTabItem
{
    self.tabBarItem.title = @"TAB-1";
    
    //不使用系统图片
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
        self.title = @"TAB-1";
        self._intPageIndex = 1;
        self.view.backgroundColor = [UIColor whiteColor];
       
    }
    return self;
}
-(void)loadView{
    [super loadView];
    [self addNavAndTabItem];
    [self addTableView];
   // CAAnimation

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


#pragma mark ============================== 添加UI

-(void)addTableView{
    EX_refreshAndLoadMoreTableView *tableView = [[EX_refreshAndLoadMoreTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-K_NAV_HEIGHT-K_STATUS_HEIGHT-K_TABBAR_HEIGHT)];
    
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView._refreshLoadMoreDelegate = self;
    
    if (IOS_VERSION < 7.0)
    {
        tableView.backgroundView = [[UIView alloc]init];
        tableView.backgroundColor = [UIColor whiteColor];
    }else
    {
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    self._tableView = tableView;
    [self.view addSubview:tableView];
    
    self._tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}
-(void)setMsgTableViewCell:(UITableViewCell*)cell Entity:(MessageEntity*)entity Color:(UIColor*)color
{
    UIView *bgv = (UIView*)[cell viewWithTag:TAG_STYLETWO_COUPON_BG];
    if (bgv) {
        [bgv setBackgroundColor:color];
    }
    
    UIImageView *imagev = (UIImageView*)[cell viewWithTag:TAG_STYLETWO_COUPON_IMAGE];
    /*
    if (imagev) {
        [imagev setImageWithURL:[NSURL URLWithString:entity.logo] placeholderImage:[UIImage imageNamed:@"loadingimg150.png"]];
    }
    */
    
    UILabel *labname = (UILabel*)[cell viewWithTag:TAG_STYLETWO_COUPON_NAME];
    if (labname) {
        [labname setText:entity.title];
    }
    
    UILabel *labtime = (UILabel*)[cell viewWithTag:TAG_STYLETWO_COUPON_TIME];
    if (labtime) {
        labtime.text =entity.time;
        
    }
    
    
    UILabel *labtime1 = (UILabel*)[cell viewWithTag:TAG_STYLETWO_COUPON_STORE];
    if (labtime1) {
        [labtime1 setText:entity.senderId];
        
    }
    
}

-(void)addCouponTableViewCell:(UITableViewCell*)cell
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 80)];
    view.tag = TAG_STYLETWO_COUPON_BG;
    view.layer.cornerRadius = 10.0f;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor redColor];
    [cell.contentView addSubview:view];
    
    UIImageView *linev = [[UIImageView alloc]initWithFrame:CGRectMake(60, 0, 6, 60)];
    [linev setImage:[UIImage imageNamed:@"youhui_sijiao.png"]];
    [view addSubview:linev];
    
    UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(14, 24, 32, 32)];
    imagev.layer.cornerRadius = 16.0f;
    imagev.layer.masksToBounds = YES;
    imagev.backgroundColor = COLOR_MY_LIGHTGRAY;
    imagev.contentMode = UIViewContentModeScaleAspectFit;
    imagev.tag = TAG_STYLETWO_COUPON_IMAGE;
    [view addSubview:imagev];
    
    UILabel *labname = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, SCREEN_WIDTH-40-70-10, 25)];
    labname.backgroundColor = [UIColor clearColor];
    labname.textColor = [UIColor whiteColor];
    labname.font = [UIFont systemFontOfSize:16];
    labname.tag = TAG_STYLETWO_COUPON_NAME;
    [view addSubview:labname];
    
    UILabel *labtimeTitle = [[UILabel alloc]initWithFrame:CGRectMake(70, 35, 40, 15)];
    labtimeTitle.backgroundColor = [UIColor clearColor];
    labtimeTitle.font = [UIFont systemFontOfSize:12];
    labtimeTitle.textColor = RGBCOLOR(253, 216, 189);
    labtimeTitle.text = @"期限:";
    [view addSubview:labtimeTitle];
    
    UILabel *labtime = [[UILabel alloc]initWithFrame:CGRectMake(105, 35, SCREEN_WIDTH-105, 15)];
    labtime.backgroundColor = [UIColor clearColor];
    labtime.font = [UIFont systemFontOfSize:12];
    labtime.textColor = RGBCOLOR(253, 216, 189);
    labtime.tag = TAG_STYLETWO_COUPON_TIME;
    [view addSubview:labtime];
    
    
    UIImageView *linev1 = [[UIImageView alloc]initWithFrame:CGRectMake(70, 54, 15, 15)];
    [linev1 setImage:[UIImage imageNamed:@"dp_icon_yh.png"]];
    [view addSubview:linev1];
    
    
    UILabel *labtime1 = [[UILabel alloc]initWithFrame:CGRectMake(87, 35+20, SCREEN_WIDTH-105, 15)];
    labtime1.backgroundColor = [UIColor clearColor];
    labtime1.font = [UIFont systemFontOfSize:12];
    labtime1.textColor = RGBCOLOR(253, 216, 189);
    labtime1.tag = TAG_STYLETWO_COUPON_STORE;
    [view addSubview:labtime1];
}

#pragma mark ============================== 刷新和加载更多
#pragma mark scrollview的代理
/* 视图滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self._tableView EX_tableScrollViewDidScroll:scrollView];
}
/* 拖拽结束 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self._tableView EX_tableScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}
#pragma mark refresh and loadmore
/* 下拉刷新 */
-(void)EX_refreshForViewController
{
    self._intPageIndex = 1;
    [self getDataFromServer];
}
/* 上拉加载 */
-(void)EX_loadMoreForViewController
{
    self._intPageIndex++;
    [self getDataFromServer];
}


-(void)getDataFromServer
{

    
    [[NetTrans getInstance] API_get_msg_list:self PageIndex:self._intPageIndex Limit:10];
    //[[NetTrans getInstance] API_ALL_MORE_SHAKE_LIST_FUNC:self CityID:cityID PageIndex:self._intPageIndex Limit:20];
}


#pragma mark ============================== table的代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self._arrData.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponCellIdentifier"];
    tableView.separatorColor = [UIColor clearColor];
    cell.selected = NO;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CouponCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addCouponTableViewCell:cell];
    }
    MessageEntity *goen = [self._arrData objectAtIndex:indexPath.row];
    
    UIColor *colorbg = nil;
    if (indexPath.row%5 == 0) {
        colorbg = RGBCOLOR(2, 174, 236);
    }
    else if (indexPath.row%5 == 1){
        colorbg = RGBCOLOR(274, 86, 130);
    }
    else if (indexPath.row%5 == 2){
        colorbg = RGBCOLOR(249, 148, 40);
    }
    else if (indexPath.row%5 == 3){
        colorbg = RGBCOLOR(240, 57, 59);
    }
    else if (indexPath.row%5 == 4){
        colorbg = RGBCOLOR(199, 94, 176);
    }
    
    [self setMsgTableViewCell:cell Entity:goen Color:colorbg];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    YouHuiCouponEntity *goen = [self._arrData objectAtIndex:indexPath.row];
    YouHuiInfoViewController *skudetail = [[YouHuiInfoViewController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:skudetail animated:YES];
    
    skudetail.entity = goen;
    [skudetail getDataFromServer];
     */
}

#pragma mark ============================== 事件
-(void)BackButtonClickEvent:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark ============================== 数据更新
-(void)updateTableViewData:(NSMutableArray*)arrData
{
    if (self._arrData)
    {
        if (self._intPageIndex == 1) {
            [self._arrData removeAllObjects];
        }
        
        [self._arrData addObjectsFromArray:arrData];
    }else
    {
        self._arrData = [NSMutableArray arrayWithArray:arrData];
    }
    
    [self._tableView reloadData];
}
#pragma mark ============================== 网络代理
-(void)requestFailed:(int)nTag withStatus:(NSString*)status withMessage:(NSString*)errMsg
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self._tableView EX_DoneLoadingTableViewData];
    if ([status isEqualToString: WEB_STATUS_0])
    {
        [[iToast makeText:errMsg] show];
    }
    else if ([status isEqualToString:WEB_STATUS_10000])
    {
        //未登录处理
    }
    else
    {
        [[iToast makeText:errMsg] show];
    }
}
-(void)responseSuccess:(NSMutableArray *)arrData nTag:(int)nTag
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if (nTag == t_API_GET_MES_LIST)
    {
        [self._tableView EX_DoneLoadingTableViewData];
        [self updateTableViewData:arrData];
    }
}


@end
