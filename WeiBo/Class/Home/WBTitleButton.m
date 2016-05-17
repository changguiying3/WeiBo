//
//  WBTitleButton.m
//  WeiBo
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBTitleButton.h"

@implementation WBTitleButton
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        //[self setTitle:@"首页" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState: UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}
-(void)layoutSubviews{
    //用于紧是调整按钮内部的titleLabel和imageView的位置
    [super layoutSubviews];
    self.imageView.x = 0.0;
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
