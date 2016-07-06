//
//  WBEmotionPageView.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//一页最多三行
#define WBEmotionMaxRows 3
//最多七列
#define WBEmotionMaxCols 7
//这一页显示的表情数
#define WBEmotionPageSize ((WBEmotionMaxRows * WBEmotionMaxCols) - 1)
@interface WBEmotionPageView : UIView

@property (nonatomic,strong) NSArray *emotions;
@end
