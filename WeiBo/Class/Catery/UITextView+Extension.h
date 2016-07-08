//
//  UITextView+Extension.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
- (void)insertAttributedText:(NSAttributedString *)text;
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;
@end
