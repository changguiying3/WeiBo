//
//  WBEmotionKeyboard.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBEmotionKeyboard.h"
#import "WBEmotionTabBar.h"
#import "WBEmotionListView.h"
#import "WBEmotion.h"
#import "MJExtension.h"
#import "WBEmotionTool.h"

@interface WBEmotionKeyboard ()<WBEmotionTabBarDelegate>
/** tabbar */
@property (nonatomic,weak) WBEmotionTabBar *tabBar;
/** 保存显示的Listview */
@property (nonatomic,weak) WBEmotionListView *showingListView;
/** 显示表情内容*/
@property (nonatomic,strong) WBEmotionListView *recentListView;
@property (nonatomic,strong) WBEmotionListView *defaultListView;
@property (nonatomic,strong) WBEmotionListView *emojiListView;
@property (nonatomic,strong) WBEmotionListView *lxhListView;
@end
@implementation WBEmotionKeyboard
-(WBEmotionListView *)recentListView{
    if (!_recentListView) {
        self.recentListView = [[WBEmotionListView alloc]init];
        //加载沙盒中的数据
        self.recentListView.emotions = [WBEmotionTool recentEmotions];
    }
    return _recentListView;
}
-(WBEmotionListView *)defaultListView{
    if (!_defaultListView) {
        self.defaultListView = [[WBEmotionListView alloc]init];
        self.defaultListView.emotions = [WBEmotionTool defaultEmotions];
    }
    return _defaultListView;
}
-(WBEmotionListView *)emojiListView{
    if (!_emojiListView) {
        self.emojiListView = [[WBEmotionListView alloc]init];
        self.emojiListView.emotions = [WBEmotionTool emojiEmotions];
    }
    return _emojiListView;
}
-(WBEmotionListView *)lxhListView{
    if (!_lxhListView) {
        self.lxhListView = [[WBEmotionListView alloc]init];
        self.lxhListView.emotions = [WBEmotionTool lxhEmotions];
    }
    return _lxhListView;
    
}
#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        WBEmotionTabBar *tabBar = [[WBEmotionTabBar alloc]init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        //表情选中的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect) name:WBEmotionDidSelectNotification object:nil];
    }
    return self;
}
-(void)emotionDidSelect{
    self.recentListView.emotions = [WBEmotionTool recentEmotions];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //tabbar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    //表情内容
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
}
#pragma mark -WBEmotionTabBarDelegate
-(void)emotionTabBar:(WBEmotionTabBar *)tabBar didSelectButton:(WBEmotionTabBarButtonType)buttonType{
    //移除正在显示的listView
    [self.showingListView removeFromSuperview];
    switch (buttonType) {
        case WBEmotionTabBarButtonTypeRecent:{
            [self addSubview:self.recentListView];
            self.showingListView = self.recentListView;
            break;
        }
        case WBEmotionTabBarButtonTypeDefault:{
            [self addSubview:self.defaultListView];
            self.showingListView = self.defaultListView;
            break;
        }
        case WBEmotionTabBarButtonTypeEmoji:{
            [self addSubview:self.emojiListView];
            self.showingListView = self.emojiListView;
            break;
        }
        case WBEmotionTabBarButtonTypeLxh:{
            [self addSubview:self.lxhListView];
            self.showingListView = self.lxhListView;
            break;
        }
    }
    //设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    //设置frame
    [self setNeedsLayout];
}
@end
