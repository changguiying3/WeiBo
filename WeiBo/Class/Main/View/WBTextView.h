//
//  WBTextView.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTextView : UITextView
/** 占位文字 */
@property (nonatomic,copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic,strong) UIColor *placeholderColor;
@end
