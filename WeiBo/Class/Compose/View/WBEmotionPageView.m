//
//  WBEmotionPageView.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBEmotionPageView.h"
#import "WBEmotion.h"
#import "WBEmotionButton.h"
#import "WBEmotionPopView.h"

@interface WBEmotionPageView()
/** 点击表情后弹出放大按钮*/
@property (nonatomic,strong) WBEmotionPopView *popView;

@end

@implementation WBEmotionPageView
-(WBEmotionPopView *)popView{
    if (!_popView) {
        self.popView = [WBEmotionPopView popView];
    }
    return _popView;
}
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = self.emotions.count;
    for (int i = 0; i<count; i++) {
        WBEmotionButton *btn = [[WBEmotionButton alloc]init];
        [self addSubview:btn];
        //设置表情数据
        btn.emotion = emotions[i];
        //监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
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
-(void)btnClick:(WBEmotionButton *)btn{
    [self.popView showFrom:btn];
    //让popView自动消失
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [self.popView removeFromSuperview];
   });
    //发出通知
    [self selectEmotion:btn.emotion];
}
-(void)selectEmotion:(WBEmotion *)emotion{
    //发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[WBSelectEmotionKey] = emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:WBEmotionDidSelectNotification object:nil userInfo:userInfo];
}
@end
