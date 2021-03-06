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
/** 微博信息内容，带有属性*/
@property(nonatomic,copy) NSAttributedString *attributedText;
/**	object	微博作者的用户信息字段 */
@property(nonatomic,strong) WBUser *user;
/**	微博创建时间*/
@property(nonatomic,copy) NSString *created_at;
/**	微博的来源*/
@property(nonatomic,copy) NSString *source;
/** 微博的配图地址 */
@property(nonatomic,strong)NSArray *pic_urls;
/** 转发微博的字段 */
@property(nonatomic,strong) WBStatus *retweeted_status;
/** 被转发原创微博的信息内容 －－ 带有属性文字的*/
@property(nonatomic,copy) NSAttributedString *retweetedAttributedText;
/** retweet count*/
@property (nonatomic,assign) NSUInteger reposts_count;
/** reweet 评论*/
@property (nonatomic,assign) NSUInteger comments_count;;
/** attitude count*/
@property (nonatomic,assign) NSUInteger attitudes_count;
@end
