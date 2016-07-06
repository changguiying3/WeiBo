//
//  WBEmotionTabBar.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WBEmotionTabBarButtonTypeRecent, // 最近
    WBEmotionTabBarButtonTypeDefault, // 默认
    WBEmotionTabBarButtonTypeEmoji, // emoji
    WBEmotionTabBarButtonTypeLxh, // 浪小花
} WBEmotionTabBarButtonType;
@class WBEmotionTabBar;
@protocol WBEmotionTabBarDelegate <NSObject>

@optional
-(void)emotionTabBar:(WBEmotionTabBar *)tabBar didSelectButton:(WBEmotionTabBarButtonType)buttonType;

@end
@interface WBEmotionTabBar : UIView
@property (nonatomic,weak) id<WBEmotionTabBarDelegate> delegate;
@end
