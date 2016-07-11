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
@end
