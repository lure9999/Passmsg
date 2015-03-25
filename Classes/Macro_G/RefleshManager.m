//
//  RefleshManager.m
//  myappone
//
//  Created by wbw on 12-12-11.
//  Copyright (c) 2012年 ChangShengTianDi std. All rights reserved.
//

#import "RefleshManager.h"

@implementation RefleshManager
@synthesize _tableOneReflesh, _tableWTSReflesh, _tableThreeReflesh, _tableThreeToLogin, _tableFiveToLogin, _tableChatReflesh, _tableFourToLogin,_tableFriendReflesh,_tableCouponReflesh;

@synthesize _HomePageRefresh;
@synthesize _GuangYiGUangRefresh;
@synthesize _GYGStoreRefresh;
@synthesize _StoreListRefresh;


static RefleshManager* shareRefleshManager = nil;
+(id) sharedRefleshManager {
	if (nil == shareRefleshManager) {
		shareRefleshManager = [[RefleshManager alloc] init];
	}
	return shareRefleshManager;
}

/* get reflesh count */
-(NSInteger)getTabThreeRefleshCount
{
    return self._tableThreeReflesh;
}
-(NSInteger)getTabOneRefleshCount
{
    return self._tableOneReflesh;
}
-(NSInteger)getTabWTSRefleshCount
{
    return self._tableWTSReflesh;
}
-(NSInteger)getTabChatRefleshCount
{
    return self._tableChatReflesh;
}
-(NSInteger)getGuangYiGuangRefreshCount
{
    return self._GuangYiGUangRefresh;
}
-(NSInteger)getGYGStoreRefreshCount
{
    return self._GYGStoreRefresh;
}
-(NSInteger)getFriendListRefreshCount
{
    return self._tableFriendReflesh;
}
-(NSInteger)getStoreListRefreshCount
{
    return self._StoreListRefresh;
}
-(NSInteger)getHomePageRefreshCount
{
    return self._HomePageRefresh;
}

-(NSInteger)getCouponPageRefreshCount
{
    return self._tableCouponReflesh;
}

/* set reflesh count */
-(void)setTabThreeRefleshCount:(NSInteger)count
{
    if (count == 0) {
        self._tableThreeReflesh = 0;
    }else {
        self._tableThreeReflesh += count;
    }
}
-(void)setTabOneRefleshCount:(NSInteger)count
{
    if (count == 0) {
        self._tableOneReflesh = 0;
    }else {
        self._tableOneReflesh += count;
    }
}
-(void)setFriendListRefleshCount:(NSInteger)count
{
    if (count == 0) {
        self._tableFriendReflesh = 0;
    }else {
        self._tableFriendReflesh += count;
    }
}
-(void)setTabWTSRefleshCount:(NSInteger)count
{
    if (count == 0) {
        self._tableWTSReflesh = 0;
    }else {
        self._tableWTSReflesh += count;
    }
}
-(void)setTabChatRefleshCount:(NSInteger)count
{
    if (count == 0) {
        self._tableChatReflesh = 0;
    }else {
        self._tableChatReflesh += count;
    }
}
-(void)setGuangYiGuangRefreshCount:(NSInteger)count
{
    if (count == 0) {
        self._GuangYiGUangRefresh= 0;
    }else {
        self._GuangYiGUangRefresh += count;
    }
}
-(void)setGYGStoreRefreshCount:(NSInteger)count
{
    if (count == 0) {
        self._GYGStoreRefresh = 0;
    }else {
        self._GYGStoreRefresh += count;
    }
}
-(void)setStoreListRefreshCount:(NSInteger)count
{
    if (count == 0) {
        self._StoreListRefresh = 0;
    }else {
        self._StoreListRefresh += count;
    }
}
-(void)setHomePageRefreshCount:(NSInteger)count
{
    if (count == 0) {
        self._HomePageRefresh = 0;
    }else {
        self._HomePageRefresh += count;
    }
}

-(void)setCouponPageRefreshCount:(NSInteger)count
{
    if (count == 0) {
        self._tableCouponReflesh = 0;
    }else {
        self._tableCouponReflesh += count;
    }
}
/**/
-(BOOL)getTableThreeToLogin
{
    return self._tableThreeToLogin;
}
-(BOOL)getTableFiveToLogin
{
    return self._tableFiveToLogin;
}
-(BOOL)getTableFourToLogin
{
    return self._tableFourToLogin;
}

/**/
-(void)setTableThreeToLogin:(BOOL)isToLogin
{
    self._tableThreeToLogin = isToLogin;
}
-(void)setTableFiveToLogin:(BOOL)isToLogin
{
    self._tableFiveToLogin = isToLogin;
}
-(void)setTableFourToLogin:(BOOL)isToLogin
{
    self._tableFourToLogin = isToLogin;
}
@end
