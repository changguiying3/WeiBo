//
//  UIBarButtonItem+Extention.h
//  WeiBo
//
//  Created by mac on 16/5/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extention)
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
