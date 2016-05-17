//
//  WBAccount.h
//  WeiBo
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject <NSCoding>
/**  用于调用access_token，接口获取授权后的access token。*/
@property(nonatomic,copy)NSString *access_token;
/**　string	access_token的生命周期，单位是秒数。*/
@property(nonatomic,copy)NSNumber *expires_in;
/**　string	当前授权用户的UID。*/
@property(nonatomic,copy)NSString *uid;
/**	access token的创建时间 */
@property(nonatomic,strong) NSDate *created_time;
/**　string	当前授权用户的name。*/
@property(nonatomic,copy)NSString *name;
+(instancetype)accountWithDict:(NSDictionary *)dict;
@end
