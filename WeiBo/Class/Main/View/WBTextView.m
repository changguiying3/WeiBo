//
//  WBTextView.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBTextView.h"

@implementation WBTextView
-(instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    if (self) {
        //通知,当文字改变时，UITextView发出UITextViewTextDidChangeNotification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
/**
 *  监听文字的改变
 */
-(void)textDidChange{
    [self setNeedsDisplay];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    //setNeedsDisplay在下一个循环时刻，调用drawRect:
    [self setNeedsDisplay];
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect{
    //有输入文字，则直接返回
    if (self.hasText) return;
    //设置文字的属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    //画文字
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
    
}

@end
