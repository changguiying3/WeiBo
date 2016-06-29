//
//  NSString+Extention.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/6/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(CGSize)sizeWithFont:(UIFont *)font{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}
@end
