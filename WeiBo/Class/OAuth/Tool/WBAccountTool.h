//
//  WBAccountTool.h
//  WeiBo
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBAccount.h"
@interface WBAccountTool : NSObject
/**
 *  存储账号信息
 */
+(void)saveAccount:(WBAccount *)account;
/**
 *  返回帐号信息
 */
+(WBAccount *)account;
@end
