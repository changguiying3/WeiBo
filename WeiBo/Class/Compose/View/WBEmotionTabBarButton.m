//
//  WBEmotionTabBarButton.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBEmotionTabBarButton.h"

@implementation WBEmotionTabBarButton
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}
@end
