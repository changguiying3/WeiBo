//
//  WBUser.h
//  WeiBo
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    WBUserVerifiedTypeNone = -1, // 没有任何认证
    
    WBUserVerifiedPersonal = 0,  // 个人认证
    
    WBUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    WBUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    WBUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    WBUserVerifiedDaren = 220 // 微博达人
} WBUserVerifiedType;
@interface WBUser : NSObject
/** string 字符串型的用户UID*/
@property(nonatomic,copy) NSString *idstr;
/**	string	友好显示名称*/
@property(nonatomic,copy) NSString *name;
/**	string	用户头像地址*/
@property(nonatomic,copy) NSString *profile_image_url;
/**会员类型*/
@property(nonatomic,assign) int mbtype;
/**会员等级*/
@property(nonatomic,assign) int mbrank;
@property(nonatomic,assign,getter=isVip) BOOL vip;
/** 认证类型 */
@property(nonatomic,assign) WBUserVerifiedType verified_type;
@end
