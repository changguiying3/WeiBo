//
//  WBEmotion.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBEmotion.h"

@interface WBEmotion()<NSCoding>

@end
@implementation WBEmotion
/**
 * 
 * 从文件中解析时调用
*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.chs = [aDecoder decodeObjectForKey:@"chs"];
        self.png = [aDecoder decodeObjectForKey:@"png"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
    }
    return self;
}
/**
 *  将对象写入文件时调用
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];
}
@end
