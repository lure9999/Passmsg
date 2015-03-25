//
//  EX_refreshAndLoadMoreTableView.m
//  base
//
//  Created by ioswang on 13-12-4.
//  Copyright (c) 2013年 wbw. All rights reserved.
//

#import "EX_refreshTableView.h"

@implementation EX_refreshTableView
@synthesize _refreshHeaderView;
@synthesize _isRefreshloading;

#pragma mark ============================== 添加刷新和加载更多
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self addRefreshDataView];
    }
    return self;
}

#pragma mark ============================== 添加刷新
-(void)addRefreshDataView
{
    if(self._refreshHeaderView == nil)
    {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
        view.delegate = self;
        self._refreshHeaderView = view;
        [self addSubview:view];
    }
}
/* 滚动 */
- (void)EX_tableScrollViewDidScroll:(UIScrollView *)scrollView
{
    [self._refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (CGFloat) footerLoadMoreHeight
{
    return 52;
}
/* 刷新 */
-(void)refreshForViewController
{
    if (self._refreshDelegate && [self._refreshDelegate respondsToSelector:@selector(EX_refreshForViewController)])
    {
        [self._refreshDelegate EX_refreshForViewController];
    }
}
/* 拖拽结束 */
- (void)EX_tableScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self._refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

/* 刷新开始 */
- (void)refreshReloadTableViewDataSource
{
    
    self._isRefreshloading = YES;
    /* 刷新函数调用 */
    [self refreshForViewController];
    
}
/* 刷新结束 */
- (void)refreshDoneLoadingTableViewData
{
    self._isRefreshloading = NO;
    [self._refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}
/* 刷新代理 */
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self refreshReloadTableViewDataSource];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return self._isRefreshloading;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    return [NSDate date];
}

/* 隐藏加载视图 */
- (void)EX_DoneLoadingTableViewData
{
    [self performSelector:@selector(refreshDoneLoadingTableViewData) withObject:nil];
}
@end
