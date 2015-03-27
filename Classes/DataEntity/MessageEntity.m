//
//  MessageEntity.m
//  passmsg
//
//  Created by Liu Zhichao on 15-3-27.
//  Copyright (c) 2015年 LiuZhiChao. All rights reserved.
//

#import "MessageEntity.h"

@implementation MessageEntity
@synthesize id,senderId,receiveTel,content,passNum,time,money,jifen;
@end


@implementation MessageListTrans
- (BOOL)requestFailed:(ASIHTTPRequest *)request
{
    if(![super requestFailed:request])
    {
        return NO;
    }
    
    NSLog(@"request fail");
    
    if([requst isCancelled])
    {
        NSLog(@"request cancel");
    }
    [uinet requestFailed:self.nTag withStatus:WEB_STATUS_0 withMessage:@"网络不给力，请稍后重试！"];
    [[NetTrans getInstance]removeNetObj:self];
    return YES;
}
-(BOOL) responseSuccess:(ASIHTTPRequest *)request{
    
    if(![super responseSuccess:request])
    {
        return NO;
    }
    NSData * myResponseData = [request responseData];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);//kCFStringEncodingUTF8
    NSString * myResponseStr = [[NSString alloc] initWithData:myResponseData encoding:enc];
    
    //NSLog(@"jsonre fren %@",myResponseStr);
    
    NSDictionary  *jsonDic = [myResponseStr objectFromJSONString];
    
    //返回结果是以Dictionary存在
    NSArray* data = [jsonDic objectForKey:@"data"];
    NSMutableArray *arrRe = [NSMutableArray array];
    
    NSString *status = [NSString stringWithFormat:@"%@",[jsonDic objectForKey:@"status"]];
    
    if([status isEqualToString:WEB_STATUS_1] ){
        
        for (NSDictionary *dataDic in data) {
            MessageEntity *entity = [[MessageEntity alloc]init];
            
            
            [entity reflectDataFromOtherObject:dataDic];
            
            [arrRe addObject:entity];

        }
    }
    if ([uinet respondsToSelector:@selector(responseSuccess:nTag:)])
    {
        [uinet responseSuccess:arrRe nTag:self.nTag];
    }
    
    [[NetTrans getInstance]removeNetObj:self];
    return YES;
}

@end