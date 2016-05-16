//
//  WBAccount.m
//  WeiBo
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBAccount.h"

@implementation WBAccount
+(instancetype)accountWithDict:(NSDictionary *)dict{
    WBAccount *account = [[WBAccount alloc]init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    return account;
}
/**
 *  将一个对象归档进沙盒
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
}
/**
 *  从沙盒中解档一个对象，取出需要的属性
 */
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
    }
    return self;
}
@end
