//
//  WBEmotionPopView.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBEmotion,WBEmotionButton;

@interface WBEmotionPopView : UIView
+ (instancetype)popView;
- (void)showFrom:(WBEmotionButton *)button;
@end
