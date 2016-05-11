//
//  WBDropdownMenu.h
//  WeiBo
//
//  Created by mac on 16/5/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBDropdownMenu;
@protocol WBDropdownMenuDelegate <NSObject>

@optional
-(void)dropdownMenuDidDismiss:(WBDropdownMenu *)menu;
-(void)dropdownMenuDidShow:(WBDropdownMenu *)menu;
@end
@interface WBDropdownMenu : UIView
+ (instancetype)menu;
//显示
-(void)showFrom:(UIView *)from;
//销毁
-(void)dismiss;
//内容
@property (nonatomic,strong) UIView *content;
//内容控制器
@property (nonatomic,strong) UIViewController *contentController;
@property (nonatomic,weak) id<WBDropdownMenuDelegate> delegate;
@end
