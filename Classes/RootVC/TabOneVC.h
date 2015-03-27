//
//  TabOneVC.h
//  passmsg
//
//  Created by Liu Zhichao on 15-3-26.
//  Copyright (c) 2015年 LiuZhiChao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EX_refreshAndLoadMoreTableView.h"

//所有优惠券列表
@interface TabOneVC  : EXRootViewController<UITableViewDataSource, UITableViewDelegate, EX_refreshAndLoadMoreTableViewDelegate,UIScrollViewDelegate>
{
    EX_refreshAndLoadMoreTableView* _tableView;
}
@property(nonatomic,strong)EX_refreshAndLoadMoreTableView* _tableView;
@end
