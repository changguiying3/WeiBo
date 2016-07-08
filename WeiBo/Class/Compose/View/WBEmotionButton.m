//
//  WBEmotionButton.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBEmotionButton.h"
#import "WBEmotion.h"

@implementation WBEmotionButton
/**
 *  代码创建时，调用的方法
 */
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
/**
 *  xib 或者storyboard时调用
 *
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}
/**
 *  对按钮进行设置
 */
- (void)setup{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.adjustsImageWhenHighlighted = NO;
}
- (void)setEmotion:(WBEmotion *)emotion{
    _emotion = emotion;
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }else if (emotion.code){
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }
}
@end
