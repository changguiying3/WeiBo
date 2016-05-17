//
//  UIWindow+Extension.m
//  WeiBo
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "WBMainController.h"
#import "WBNewFeatureController.h"

@implementation UIWindow (Extension)
-(void)switchRootViewController{
        NSString *key = @"CFBundleVersion";
    //上次使用的版本号
        NSString *lastVertion = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    //当前的版本号
       NSString *currentVertion = [NSBundle mainBundle].infoDictionary[key];
        if ([currentVertion isEqualToString:lastVertion]) {
            self.rootViewController = [[WBMainController alloc]init];
        }else{
            self.rootViewController = [[WBNewFeatureController alloc]init];
            //将版本号存进沙盒
            [[NSUserDefaults standardUserDefaults]setObject:currentVertion forKey:key];
             [[NSUserDefaults standardUserDefaults]synchronize];
        }
}
@end
