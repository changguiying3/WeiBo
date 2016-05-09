//
//  UIBarButtonItem+Extention.m
//  WeiBo
//
//  Created by mac on 16/5/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIBarButtonItem+Extention.h"

@implementation UIBarButtonItem (Extention)
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:image]forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
