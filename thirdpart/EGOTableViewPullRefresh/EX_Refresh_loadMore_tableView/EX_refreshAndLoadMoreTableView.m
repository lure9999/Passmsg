//
//  EX_refreshAndLoadMoreTableView.m
//  base
//
//  Created by ioswang on 13-12-4.
//  Copyright (c) 2013年 wbw. All rights reserved.
//

#import "EX_refreshAndLoadMoreTableView.h"

@implementation EX_refreshAndLoadMoreTableView
@synthesize _refreshLoadMoreDelegate;
@synthesize _refreshHeaderView;
@synthesize _loadMoreFooterView;
@synthesize _isLoadMoreLoading;
@synthesize _isRefreshloading;

#pragma mark ============================== 添加刷新和加载更多
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addRefreshDataView];
        [self addLoadMoreDataView];
    }
    return self;
}

#pragma mark ============================== 添加刷新和加载更多
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
-(void)addLoadMoreDataView
{
    if (self._loadMoreFooterView == nil) {
		WBLoadMoreTableFootView *view = [[WBLoadMoreTableFootView alloc] initWithFrame:CGRectMake(0.0f, self.contentSize.height, self.frame.size.width, self.bounds.size.height)];
		view.delegate = self;
		[self addSubview:view];
		self._loadMoreFooterView = view;

	}
}
/* 滚动 */
- (void)EX_tableScrollViewDidScroll:(UIScrollView *)scrollView
{
	[self._loadMoreFooterView loadMoreScrollViewDidScroll:scrollView];
	[self._refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
//    if (!self._isRefreshloading && self.isDragging && scrollView.contentOffset.y < 0) {
//        
//    } else if (!self._isLoadMoreLoading) {
//        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
//        if (scrollPosition < 10 * [self footerLoadMoreHeight]) {
//            [self._loadMoreFooterView loadMoreScrollViewDidEndDragging:scrollView];
//        }
//    }
}
- (CGFloat) footerLoadMoreHeight
{
    if (self._loadMoreFooterView)
        return _loadMoreFooterView.frame.size.height;
    else
        return 52;
}
/* 拖拽结束 */
- (void)EX_tableScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self._refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [self._loadMoreFooterView loadMoreScrollViewDidEndDragging:scrollView];
}

/* 刷新开始 */
- (void)refreshReloadTableViewDataSource
{
    //如果正在加载更多，禁止刷新
    if (self._isLoadMoreLoading) {
        return;
    }
    
    self._isRefreshloading = YES;
    /* 刷新函数调用 */
    [self refreshForViewController];
    
    /* 临时测试 *///[self performSelector:@selector(refreshDoneLoadingTableViewData) withObject:nil afterDelay:3];
}
/* 刷新结束 */
- (void)refreshDoneLoadingTableViewData
{
    self._isRefreshloading = NO;
    if (self._refreshHeaderView)
    {
        [self._refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    }
    
}
/* 加载更多开始 */
- (void)loadMoreLoadingTableViewDataSource
{
    //如果正在刷新，禁止加载更多
    if (self._isRefreshloading) {
        return;
    }
    self._isLoadMoreLoading = YES;
    /* 加载更多函数调用 */
    [self loadMoreForViewController];
    /* 临时测试 */
    //[self performSelector:@selector(loadMoreDonelLoadingTableViewData) withObject:nil afterDelay:3];
}
/* 加载更多结束 */
- (void)loadMoreDonelLoadingTableViewData
{
    self._isLoadMoreLoading = NO;
    if (self._loadMoreFooterView)
    {
        [self._loadMoreFooterView loadMoreScrollViewDataSourceDidFinishedLoading:self];
    }
    
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
/* 加载更多代理 */
- (void)loadMoreTableFooterDidTriggerRefresh:(WBLoadMoreTableFootView *)view
{
	[self loadMoreLoadingTableViewDataSource];
}
- (BOOL)loadMoreTableFooterDataSourceIsLoading:(WBLoadMoreTableFootView *)view
{
	return self._isLoadMoreLoading;
}
/* 刷新 */
-(void)refreshForViewController
{
    if (self._refreshLoadMoreDelegate && [self._refreshLoadMoreDelegate respondsToSelector:@selector(EX_refreshForViewController)])
    {
        [self._refreshLoadMoreDelegate EX_refreshForViewController];
    }
}
/* 加载更多 */
-(void)loadMoreForViewController
{
    if (self._refreshLoadMoreDelegate && [self._refreshLoadMoreDelegate respondsToSelector:@selector(EX_loadMoreForViewController)])
    {
        [self._refreshLoadMoreDelegate EX_loadMoreForViewController];
    }
}
/* 隐藏加载视图 */
- (void)EX_DoneLoadingTableViewData
{
    [self performSelector:@selector(loadMoreDonelLoadingTableViewData) withObject:nil];
    [self performSelector:@selector(refreshDoneLoadingTableViewData) withObject:nil];
}
@end
