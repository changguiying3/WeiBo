//
//  WBEmotionPageView.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBEmotionPageView.h"
#import "WBEmotion.h"

@implementation WBEmotionPageView
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = self.emotions.count;
    for (int i = 0; i<count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        WBEmotion *emotion = emotions[i];
           if (emotion.png) { // 有图片
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        } else if (emotion.code) { // 是emoji表情
            // 设置emoji
            [btn setTitle:emotion.code.emoji forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:32];
        }
            [self addSubview:btn];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //内边距
    CGFloat inset = 20;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) /WBEmotionMaxCols;
    CGFloat btnH = (self.height - inset)/WBEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i%WBEmotionMaxCols) * btnW;
        btn.y = inset + (i/WBEmotionMaxCols) * btnH;
    }
    
}
@end
