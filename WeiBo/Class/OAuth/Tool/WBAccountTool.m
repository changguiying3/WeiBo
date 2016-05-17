//
//  WBAccountTool.m
//  WeiBo
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//
#define WBAcountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"account.archive"]

#import "WBAccountTool.h"
#import "WBAccount.h"
@implementation WBAccountTool
/**
 *  存储帐号信息
 *
 *  @param account 帐号模型
 */
+(void)saveAccount:(WBAccount *)account{
    
    //自定义的存储必须用NSKeyedArchiver
    [NSKeyedArchiver archiveRootObject:account toFile:WBAcountPath];
  }
/**
 *  返回帐号信息
 *
 *  @return 帐号模型
 */
+(WBAccount *)account{
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:WBAcountPath];
    //过期秒数
    long long expires_in = [account.expires_in longLongValue];
    //获得过期时间
   NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    //获得当前的时间
    NSDate *now = [NSDate date];
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
    return account;
}
@end
