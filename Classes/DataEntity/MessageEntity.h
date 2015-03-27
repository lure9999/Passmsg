//
//  MessageEntity.h
//  passmsg
//
//  Created by Liu Zhichao on 15-3-27.
//  Copyright (c) 2015年 LiuZhiChao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageEntity : NSObject
@property (retain,nonatomic) NSString *senderId;
@property (retain,nonatomic) NSString *content;
@property (retain,nonatomic) NSString *time;
@property (retain,nonatomic) NSString *id;
@property (retain,nonatomic) NSString *passNum;
@property (retain,nonatomic) NSString *jifen;
@property (retain,nonatomic) NSString *receiveTel;
@property (retain,nonatomic) NSString *money;
@property (retain,nonatomic) NSString *title;
@end

@interface MessageListTrans : NetTransObj
{
    
}
@end