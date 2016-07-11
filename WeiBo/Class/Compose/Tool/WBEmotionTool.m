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

@implementation WBEmotionTool
static NSMutableArray *_recentEmotions;
+(void)initialize{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:WBRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}
+(void)addRecentEmotion:(WBEmotion *)emotion{
    //加载沙盒中的表情数据
    [_recentEmotions removeObject:emotion];
    //将表情放在数组的最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    // 将所有的表情都存入到沙盒中
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:WBRecentEmotionsPath];
}
+ (NSArray *)recentEmotions{
    return _recentEmotions;
}
@end
