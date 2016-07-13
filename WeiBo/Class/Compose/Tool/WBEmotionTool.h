//
//  WBEmotionTool.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBEmotion;

@interface WBEmotionTool : NSObject
+ (void)addRecentEmotion:(WBEmotion *)emotion;
+ (NSArray *)recentEmotions;
+ (NSArray *)defaultEmotions;
+ (NSArray *)lxhEmotions;
+ (NSArray *)emojiEmotions;
/**
 *  通过表情描述找到对应的表情
 */
+ (WBEmotion *)emotionWithChs:(NSString *)chs;
@end
