//
//  RefreshTMQuiltView.h
//  mystoreCustomer
//
//  Created by liuyao on 14-2-28.
//  Copyright (c) 2014年 ChangShengTianDi std. All rights reserved.
//

#import "TMQuiltView.h"
#import "EGORefreshTableHeaderView.h"
#import "WBLoadMoreTableFootView.h"

@protocol TM_RefreshTMQuiltViewDelegate<NSObject>
- (void)TM_refreshForViewController;    //上拉刷新代理函数
- (void)TM_loadMoreForViewController;   //下拉加载更多代理函数
@end;

@interface RefreshTMQuiltView : TMQuiltView<EGORefreshTableHeaderDelegate, WBLoadMoreTableFooterDelegate>
{
}
@property (nonatomic, assign) id<TM_RefreshTMQuiltViewDelegate> _refreshLoadMoreDelegate;
@property (nonatomic, retain, getter = get_refreshHeaderView) EGORefreshTableHeaderView *_refreshHeaderView;
@property (nonatomic, retain, getter = get_loadMoreFooterView) WBLoadMoreTableFootView   *_loadMoreFooterView;
@property (nonatomic, assign) BOOL                      _isLoadMoreLoading;
@property (nonatomic, assign) BOOL                      _isRefreshloading;
@property (nonatomic, assign) BOOL                      _hasMore;

- (void)refreshReloadTMQuiltViewDataSource;
- (void)refreshDoneLoadingTMQuiltViewData;
- (void)loadMoreLoadingTMQuiltViewDataSource;
- (void)loadMoreDonelLoadingTMQuiltViewData;
- (void)hasMoreData:(BOOL)hasMore;

- (void)TM_TMQuiltViewDidScroll:(UIScrollView *)scrollView;
- (void)TM_TMQuiltViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)TM_DoneLoadingTMQuiltViewData;

@end
