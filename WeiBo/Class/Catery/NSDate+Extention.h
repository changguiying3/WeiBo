//
//  NSDate+Extention.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/6/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extention)
/**
 *  是否是今年
 */
-(BOOL)isThisYear;
/**
 *  判断是否是昨天
 */
-(BOOL)isYesterday;
/**
 *  判断是否为今天
 */
-(BOOL)isToday;
@end
