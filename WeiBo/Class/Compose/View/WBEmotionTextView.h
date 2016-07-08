//
//  WBEmotionTextView.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBTextView.h"
@class WBEmotion;

@interface WBEmotionTextView : WBTextView
- (void)insertEmotion:(WBEmotion *)emotion;
- (NSString *)fullText;
@end
