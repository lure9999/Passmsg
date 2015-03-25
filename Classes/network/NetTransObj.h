//
//  NetTransObj.h
//  TestForNet
//
//  Created by xiu fiona on 13-2-22.
//  Copyright (c) 2013年 xiu fiona. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ASIHTTPRequest.h"
#import "NetTrans.h"
#import "MACROS_P.h"
#import "JSONKit.h"

@protocol UINetTransDelegate <NSObject>//界面对象接口
@optional
-(void)requestFailed:(int)nTag withStatus:(NSString*)status withMessage:(NSString*)errMsg;
-(void)requestCancel:(int)nTag;
-(void)responseSuccess:(NSMutableArray *)arrData nTag:(int)nTag;
-(void)responseSuccessObj:(id)netTransObj nTag:(int)nTag;
-(void)setProgress:(float)newProgress;
-(void)responseSuccessObjWithMess:(id)netTransObj nTag:(int)nTag message:(NSString*)message;
@end

//网络通信对象-与指令相对应
@interface NetTransObj : NSObject{
    id<UINetTransDelegate> uinet;//界面对象
    ASIFormDataRequest* requst;
    ASIHTTPRequest *getRequest;
    int nTag;
    int nApiTag;
}
@property (nonatomic, assign,readwrite)int nTag;
@property (nonatomic, assign,readwrite)int nApiTag;
@property (nonatomic, strong,readwrite)id<UINetTransDelegate> uinet;
@property (nonatomic, strong,readwrite)ASIFormDataRequest* requst;
@property (nonatomic, strong,readwrite)ASIHTTPRequest *getRequest;

-(id)init:(id<UINetTransDelegate>)ui nITag:(int)nITag nApi:(int)nApi;
- (BOOL)requestFailed:(ASIHTTPRequest *)request;
-(BOOL) responseSuccess:(ASIHTTPRequest *)request;
-(NSString*)testErroStr:(id)text;
-(id)testErroArray:(id)text;
@end