//
//  UITextView+Extension.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
-(void)insertAttributedText:(NSAttributedString *)text{
    [self insertAttributedText:text settingBlock:nil];
}
-(void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
     //拼接之前的图片和文字
    [attributedText appendAttributedString:self.attributedText];
    //拼接其它文字
    NSUInteger loc = self.selectedRange.location;
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    //调用外面传进来的代码
    if (settingBlock) {
        settingBlock(attributedText);
    }
    self.attributedText = attributedText;
    self.selectedRange = NSMakeRange(loc + 1, 0);
}
@end
