//
//  WBUser.m
//  WeiBo
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBUser.h"

@implementation WBUser
-(void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}
@end
