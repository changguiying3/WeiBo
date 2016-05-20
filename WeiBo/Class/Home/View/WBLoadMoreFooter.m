//
//  WBLoadMoreFooter.m
//  WeiBo
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBLoadMoreFooter.h"

@implementation WBLoadMoreFooter
+(instancetype)footer{
    return [[[NSBundle mainBundle]loadNibNamed:@"WBLoadMoreFooter" owner:nil options:nil]lastObject];
}
@end
