//
//  WBMainController.m
//  WeiBo
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBMainController.h"
#import "WBHomeViewController.h"
#import "WBMassegeViewController.h"
#import "WBDiscoverViewController.h"
#import "WBProfileViewController.h"
#import "WBNavigationController.h"
#import "WBTabBar.h"
#import "WBComposeViewController.h"
@interface WBMainController ()<WBTabBarDelegate>

@end

@implementation WBMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UITabBarController *tabbarVC = [[UITabBarController alloc]init];
    /**
     设置各个控制器
     */
    WBHomeViewController *home =[[WBHomeViewController alloc]init];
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    WBMassegeViewController *message = [[WBMassegeViewController alloc]init];
    [self addChildVc:message title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    WBDiscoverViewController  *find = [[WBDiscoverViewController alloc]init];
    [self addChildVc:find title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    WBProfileViewController *profile = [[WBProfileViewController alloc]init];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    WBTabBar *tabBar = [[WBTabBar alloc]init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  设置控制器的图片和颜色
 *
 */
-(void)addChildVc:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)seletedImage{
    //childVC.view.backgroundColor = WBRandomColor;
    //childVC.tabBarItem.title = title;
    //childVC.navigationItem.title = title;
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:seletedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = WBColor(123, 123, 123);
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    WBNavigationController *nav = [[WBNavigationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:nav];
}
-(void)tabBarDidClickPlusButton:(WBTabBar *)tabbar{
    WBComposeViewController *compose = [[WBComposeViewController alloc]init];
    WBNavigationController *nav = [[WBNavigationController alloc]initWithRootViewController:compose];
    //compose.view.backgroundColor = [UIColor redColor];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
