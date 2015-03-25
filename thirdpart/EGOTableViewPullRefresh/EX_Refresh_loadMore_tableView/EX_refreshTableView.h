//
//  EX_refreshAndLoadMoreTableView.h
//  base
//
//  Created by ioswang on 13-12-4.
//  Copyright (c) 2013年 wbw. All rights reserved.
//
//  带下拉刷新的tableview

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@protocol EX_refreshTableViewDelegate <NSObject>
- (void)EX_refreshForViewController;    //上拉刷新代理函数

@end


@interface EX_refreshTableView : UITableView<EGORefreshTableHeaderDelegate>
@property (nonatomic, weak) id<EX_refreshTableViewDelegate> _refreshDelegate;
@property (nonatomic, strong) EGORefreshTableHeaderView *_refreshHeaderView;


@property (nonatomic, assign) BOOL                      _isRefreshloading;

- (void)refreshReloadTableViewDataSource;
- (void)refreshDoneLoadingTableViewData;


- (void)EX_tableScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)EX_tableScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)EX_DoneLoadingTableViewData;

@end





