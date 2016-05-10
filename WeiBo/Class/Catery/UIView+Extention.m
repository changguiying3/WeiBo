//
//  UIView+Extention.m
//  WeiBo
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIView+Extention.h"

@implementation UIView (Extention)
-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(CGFloat)y{
    return self.frame.origin.y;
}
-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(CGFloat)height{
    return self.size.height;
}
-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(CGFloat)width{
    return self.size.width;
}
-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(CGSize)size{
    return self.frame.size;
}
-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
-(CGPoint)origin{
    return self.frame.origin;
}
-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(CGFloat)centerX{
    return self.centerX;
}
-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
-(CGFloat)centerY{
    return self.centerY;
}
@end
