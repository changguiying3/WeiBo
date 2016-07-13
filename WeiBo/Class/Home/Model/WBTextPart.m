//
//  WBTextPart.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBTextPart.h"

@implementation WBTextPart
-(NSString *)description{
    return [NSString stringWithFormat:@"%@ - %@",self.text,NSStringFromRange(self.range)];
}
@end
