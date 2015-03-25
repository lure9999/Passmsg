//
//  RefreshTMQuiltView.m
//  mystoreCustomer
//
//  Created by liuyao on 14-2-28.
//  Copyright (c) 2014年 ChangShengTianDi std. All rights reserved.
//

#import "RefreshTMQuiltView.h"

@implementation RefreshTMQuiltView
@synthesize _loadMoreFooterView;
- (void)dealloc
{
//    _loadMoreFooterView = nil;
//    self._refreshHeaderView = nil;
//    self._refreshLoadMoreDelegate = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self._hasMore = YES;
        [self get_refreshHeaderView];
        [self get_loadMoreFooterView];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark ============================== 添加刷新和加载更多
-(EGORefreshTableHeaderView *)get_refreshHeaderView
{
    if(__refreshHeaderView == nil)
    {
        __refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
        __refreshHeaderView.delegate = self;
        [self addSubview:__refreshHeaderView];
        [__refreshHeaderView release];
    }
    return __refreshHeaderView;
}
-(WBLoadMoreTableFootView *)get_loadMoreFooterView
{
    if (_loadMoreFooterView == nil && self._hasMore) {
        CGFloat h = MAX(self.contentSize.height, CGRectGetHeight(self.bounds));
		_loadMoreFooterView = [[WBLoadMoreTableFootView alloc] initWithFrame:CGRectMake(0.0f, h, self.frame.size.width, self.bounds.size.height)];
		_loadMoreFooterView.delegate = self;
		[self addSubview:_loadMoreFooterView];
        [_loadMoreFooterView release];
	}
    return _loadMoreFooterView;
}
/* 滚动 */
- (void)TM_TMQuiltViewDidScroll:(UIScrollView *)scrollView
{
	[_loadMoreFooterView loadMoreScrollViewDidScroll:scrollView];
	[self._refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    //    if (!self._isRefreshloading && self.isDragging && scrollView.contentOffset.y < 0) {
    //
    //    } else if (!self._isLoadMoreLoading) {
    //        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
    //        if (scrollPosition < 10 * [self footerLoadMoreHeight]) {
    //            [_loadMoreFooterView loadMoreScrollViewDidEndDragging:scrollView];
    //        }
    //    }
}
- (CGFloat) footerLoadMoreHeight
{
    if (_loadMoreFooterView)
        return _loadMoreFooterView.frame.size.height;
    else
        return 52;
}
/* 拖拽结束 */
- (void)TM_TMQuiltViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self._refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_loadMoreFooterView loadMoreScrollViewDidEndDragging:scrollView];
}

/* 刷新开始 */
- (void)refreshReloadTMQuiltViewDataSource
{
    //如果正在加载更多，禁止刷新
    if (self._isLoadMoreLoading) {
        return;
    }
    
    self._isRefreshloading = YES;
    self._hasMore = YES;
    /* 刷新函数调用 */
    [self refreshForViewController];
    
    /* 临时测试 *///[self performSelector:@selector(refreshDoneLoadingTableViewData) withObject:nil afterDelay:3];
}
/* 刷新结束 */
- (void)refreshDoneLoadingTMQuiltViewData
{
    self._isRefreshloading = NO;
    [self._refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}
/* 加载更多开始 */
- (void)loadMoreLoadingTMQuiltViewDataSource
{
    //如果正在刷新，禁止加载更多
    if (self._isRefreshloading) {
        return;
    }
    if (self._hasMore) {
        self._isLoadMoreLoading = YES;
        /* 加载更多函数调用 */
        [self loadMoreForViewController];
    }
}
/* 加载更多结束 */
- (void)loadMoreDonelLoadingTMQuiltViewData
{
    self._isLoadMoreLoading = NO;
    [_loadMoreFooterView loadMoreScrollViewDataSourceDidFinishedLoading:self];
}
- (void)hasMoreData:(BOOL)hasMore
{
    self._hasMore = hasMore;
    if ( !hasMore) {
        _loadMoreFooterView.delegate = nil;
        [_loadMoreFooterView removeFromSuperview];
        _loadMoreFooterView = nil;
//        _loadMoreFooterView = nil;
    }else {
        [self get_loadMoreFooterView];
    }
}

/* 刷新代理 */
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self refreshReloadTMQuiltViewDataSource];
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
    [self loadMoreLoadingTMQuiltViewDataSource];
}
- (BOOL)loadMoreTableFooterDataSourceIsLoading:(WBLoadMoreTableFootView *)view
{
	return self._isLoadMoreLoading;
}
/* 刷新 */
-(void)refreshForViewController
{
    if (self._refreshLoadMoreDelegate && [self._refreshLoadMoreDelegate respondsToSelector:@selector(TM_refreshForViewController)])
    {
        [self._refreshLoadMoreDelegate TM_refreshForViewController];
    }
}
/* 加载更多 */
-(void)loadMoreForViewController
{
    if (self._refreshLoadMoreDelegate && [self._refreshLoadMoreDelegate respondsToSelector:@selector(TM_loadMoreForViewController)])
    {
        [self._refreshLoadMoreDelegate TM_loadMoreForViewController];
    }
}
/* 隐藏加载视图 */
- (void)TM_DoneLoadingTMQuiltViewData
{
    [self performSelector:@selector(loadMoreDonelLoadingTMQuiltViewData) withObject:nil];
    [self performSelector:@selector(refreshDoneLoadingTMQuiltViewData) withObject:nil];
}

@end
