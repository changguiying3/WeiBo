//
//  WBStatus.h
//  WeiBo
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBUser;
@interface WBStatus : NSObject
/**	string	字符串型的微博ID*/
@property(nonatomic,copy)NSString *idstr;
/**	string	微博信息内容*/
@property(nonatomic,copy) NSString *text;
/**	object	微博作者的用户信息字段 */
@property(nonatomic,strong) WBUser *user;
/**	微博创建时间*/
@property(nonatomic,copy) NSString *created_at;
/**	微博的来源*/
@property(nonatomic,copy) NSString *source;
/** 微博的配图地址 */
@property(nonatomic,strong)NSArray *pic_urls;
@end
