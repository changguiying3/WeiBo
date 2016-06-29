//
//  WBStatusToolbar.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatus;
@interface WBStatusToolbar : UIView
+(instancetype)toolbar;
@property(nonatomic,strong) WBStatus *status;
@end
