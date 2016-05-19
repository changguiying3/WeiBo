//
//  WBUser.h
//  WeiBo
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUser : NSObject
/** string 字符串型的用户UID*/
@property(nonatomic,copy) NSString *idstr;
/**	string	友好显示名称*/
@property(nonatomic,copy) NSString *name;
/**	string	用户头像地址，50×50像素*/
@property(nonatomic,copy) NSString *profile_image_url;
@end