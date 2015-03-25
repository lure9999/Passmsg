//
//  EX_refreshAndLoadMoreTableView.h
//  base
//
//  Created by ioswang on 13-12-4.
//  Copyright (c) 2013年 wbw. All rights reserved.
//
//  带下拉刷新和上拉加载更多的tableview

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "WBLoadMoreTableFootView.h"


@protocol EX_refreshAndLoadMoreTableViewDelegate <NSObject>
- (void)EX_refreshForViewController;    //上拉刷新代理函数
- (void)EX_loadMoreForViewController;   //下拉加载更多代理函数
@end

@interface EX_refreshAndLoadMoreTableView : UITableView<WBLoadMoreTableFooterDelegate,EGORefreshTableHeaderDelegate>

@property (nonatomic, weak) id<EX_refreshAndLoadMoreTableViewDelegate> _refreshLoadMoreDelegate;
@property (nonatomic, strong) EGORefreshTableHeaderView *_refreshHeaderView;
@property (nonatomic, strong) WBLoadMoreTableFootView   *_loadMoreFooterView;
@property (nonatomic, assign) BOOL                      _isLoadMoreLoading;
@property (nonatomic, assign) BOOL                      _isRefreshloading;

- (void)refreshReloadTableViewDataSource;
- (void)refreshDoneLoadingTableViewData;
- (void)loadMoreLoadingTableViewDataSource;
- (void)loadMoreDonelLoadingTableViewData;

- (void)EX_tableScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)EX_tableScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)EX_DoneLoadingTableViewData;

@end





