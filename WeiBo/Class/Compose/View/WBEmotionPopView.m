//
//  WBEmotionPopView.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBEmotionPopView.h"
#import "WBEmotionButton.h"
#import "WBEmotion.h"

@interface WBEmotionPopView()

@property (weak, nonatomic) IBOutlet WBEmotionButton *emotionButton;


@end
@implementation WBEmotionPopView
+ (instancetype)popView{
    return [[[NSBundle mainBundle] loadNibNamed:@"WBEmotionPopView" owner:nil options:nil]lastObject];
}
- (void)showFrom:(WBEmotionButton *)button{
    if (button == nil) return;
    //给popView传递数据
    self.emotionButton.emotion = button.emotion;/////////
    //取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    // 计算frame
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) - self.height;
    self.centerX = CGRectGetMidX(btnFrame);
}
@end
