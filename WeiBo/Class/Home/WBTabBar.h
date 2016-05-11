//
//  WBTabBar.h
//  WeiBo
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBTabBar;
//设置代理的遵循协议
@protocol WBTabBarDelegate <UITabBarDelegate>
//设置代理方法
@optional
-(void) tabBarDidClickPlusButton:(WBTabBar *)tabbar;
@end
//设置代理属性
@interface WBTabBar : UITabBar
@property(nonatomic,weak) id<WBTabBarDelegate> delegate;
@end
