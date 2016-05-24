//
//  WBStatus.m
//  WeiBo
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBStatus.h"
#import "MJExtension.h"
#import "WBPhoto.h"

@implementation WBStatus
-(NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[WBPhoto class]};
}
@end
