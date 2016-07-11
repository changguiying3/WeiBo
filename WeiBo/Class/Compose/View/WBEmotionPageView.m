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
#import "WBEmotionTool.h"

@interface WBEmotionPageView()
/** 点击表情后弹出放大按钮*/
@property (nonatomic,strong) WBEmotionPopView *popView;
/** 删除按钮*/
@property (nonatomic,weak) UIButton *deleteButton;
@end

@implementation WBEmotionPageView
-(WBEmotionPopView *)popView{
    if (!_popView) {
        self.popView = [WBEmotionPopView popView];
    }
    return _popView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        //添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}
/**
 *  获得手指位置所在的表情按钮
 */
- (WBEmotionButton *)emotionButtonWithLocation:(CGPoint)location{
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i++) {
        WBEmotionButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            return btn;
        }
    }
    return nil;
}
/**
 *  处理长按手势
 */
- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer{
    CGPoint location = [recognizer locationInView:recognizer.view];
    //获得表情按钮
    WBEmotionButton *btn = [self emotionButtonWithLocation:location];
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self.popView removeFromSuperview];
            if (btn) {
                //发出通知
                [self selectEmotion:btn.emotion];
            }
            break;
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            [self.popView showFrom:btn];
        default:
            break;
    }
}
-(void)deleteClick{
    [[NSNotificationCenter defaultCenter]postNotificationName:WBEmotionDidDeleteNotification object: nil];
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
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i%WBEmotionMaxCols) * btnW;
        btn.y = inset + (i/WBEmotionMaxCols) * btnH;
    }
    //删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.y = self.height - btnH;
    self.deleteButton.x = self.width - inset - btnW;
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
    //将表情存进沙盒
    [WBEmotionTool addRecentEmotion:emotion];
    //发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[WBSelectEmotionKey] = emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:WBEmotionDidSelectNotification object:nil userInfo:userInfo];
}
@end
