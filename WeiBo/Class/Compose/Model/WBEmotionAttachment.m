//
//  WBEmotionAttachment.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBEmotionAttachment.h"
#import "WBEmotion.h"
@implementation WBEmotionAttachment
-(void)setEmotion:(WBEmotion *)emotion{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}
@end
