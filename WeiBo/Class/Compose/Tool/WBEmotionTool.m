//
//  WBEmotionTool.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/8.
//  Copyright © 2016年 mac. All rights reserved.
//
#define WBRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

#import "WBEmotionTool.h"
#import "WBEmotion.h"
#import "MJExtension.h"

@implementation WBEmotionTool
static NSMutableArray *_recentEmotions;
+(void)initialize{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:WBRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}
+(WBEmotion *)emotionWithChs:(NSString *)chs{
    NSArray *defaults = [self defaultEmotions];
    for (WBEmotion *emotion in defaults) {
        if ([emotion.chs isEqualToString:chs])return emotion;
       }
      NSArray *lxhs = [self lxhEmotions];
    for (WBEmotion *emotion in lxhs) {
        if ([emotion.chs isEqualToString:chs])return emotion;
      }
    return nil;
}
+(void)addRecentEmotion:(WBEmotion *)emotion{
    //加载沙盒中的表情数据
    [_recentEmotions removeObject:emotion];
    //将表情放在数组的最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    // 将所有的表情都存入到沙盒中
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:WBRecentEmotionsPath];
}
/**
 *  返回装有模型的数组
 */
+ (NSArray *)recentEmotions{
    return _recentEmotions;
}
static NSArray *_emojiEmotions, *_defaultEmotions, *_lxhEmotions;
+ (NSArray *)defaultEmotions{
    if (!_defaultEmotions) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"default.info.plist" ofType:nil];
        _defaultEmotions = [WBEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultEmotions;
}
+ (NSArray *)emojiEmotions{
    if (!_emojiEmotions) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"emoji.info.plist" ofType:nil];
        _emojiEmotions = [WBEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiEmotions;
}
+ (NSArray *)lxhEmotions{
    if (!_lxhEmotions) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"lxh.info.plist" ofType:nil];
        _lxhEmotions = [WBEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhEmotions;
}

@end
