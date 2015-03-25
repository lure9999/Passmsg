//
//  RefleshManager.h
//  myappone
//
//  Created by wbw on 12-12-11.
//  Copyright (c) 2012年 ChangShengTianDi std. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefleshManager : NSObject
{
    NSInteger   _tableThreeReflesh; //我的购物墙刷新
    NSInteger   _tableOneReflesh;   //逛一逛界面刷新
    NSInteger   _tableWTSReflesh;  //微通社刷新
    NSInteger   _tableChatReflesh;//聊天刷新
    NSInteger   _GuangYiGUangRefresh; //逛一逛刷新
    NSInteger   _GYGStoreRefresh;     //试点页面刷新
    NSInteger   _StoreListRefresh;    //逛一逛商户列表刷新
    NSInteger   _HomePageRefresh;//附近
    NSInteger _tableFriendReflesh;//朋友列表刷新
    
    NSInteger _tableCouponReflesh;//优惠列表刷新
    
    BOOL        _tableThreeToLogin;
    BOOL        _tableFiveToLogin;
    BOOL        _tableFourToLogin;
}
@property (nonatomic, assign) NSInteger _tableFriendReflesh;
@property (nonatomic, assign) NSInteger   _tableThreeReflesh;
@property (nonatomic, assign) NSInteger   _tableOneReflesh;
@property (nonatomic, assign) NSInteger   _tableWTSReflesh;
@property (nonatomic, assign) NSInteger   _tableChatReflesh;
@property (nonatomic, assign) NSInteger   _GuangYiGUangRefresh;
@property (nonatomic, assign) NSInteger   _GYGStoreRefresh;
@property (nonatomic, assign) NSInteger   _StoreListRefresh;
@property (nonatomic, assign) NSInteger   _HomePageRefresh;
@property (nonatomic, assign) NSInteger   _tableCouponReflesh;

@property (nonatomic, assign) BOOL        _tableThreeToLogin;
@property (nonatomic, assign) BOOL        _tableFiveToLogin;
@property (nonatomic, assign) BOOL        _tableFourToLogin;

+(id) sharedRefleshManager;


/* set reflesh count */
-(void)setFriendListRefleshCount:(NSInteger)count;
-(void)setTabThreeRefleshCount:(NSInteger)count;
-(void)setTabOneRefleshCount:(NSInteger)count;
-(void)setTabWTSRefleshCount:(NSInteger)count;
-(void)setTabChatRefleshCount:(NSInteger)count;
-(void)setGuangYiGuangRefreshCount:(NSInteger)count;
-(void)setGYGStoreRefreshCount:(NSInteger)count;
-(void)setStoreListRefreshCount:(NSInteger)count;
-(void)setHomePageRefreshCount:(NSInteger)count;
-(void)setCouponPageRefreshCount:(NSInteger)count;


/* get reflesh count */
-(NSInteger)getFriendListRefreshCount;
-(NSInteger)getTabThreeRefleshCount;
-(NSInteger)getTabOneRefleshCount;
-(NSInteger)getTabWTSRefleshCount;
-(NSInteger)getTabChatRefleshCount;
-(NSInteger)getGuangYiGuangRefreshCount;
-(NSInteger)getGYGStoreRefreshCount;
-(NSInteger)getStoreListRefreshCount;
-(NSInteger)getHomePageRefreshCount;
-(NSInteger)getCouponPageRefreshCount;

/* get to login */
-(BOOL)getTableThreeToLogin;
-(BOOL)getTableFiveToLogin;
-(BOOL)getTableFourToLogin;

/* set to login */
-(void)setTableThreeToLogin:(BOOL)isToLogin;
-(void)setTableFiveToLogin:(BOOL)isToLogin;
-(void)setTableFourToLogin:(BOOL)isToLogin;
@end
