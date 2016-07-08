//
//  WBEmotionTextView.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBEmotionTextView.h"
#import "WBEmotion.h"
#import "WBEmotionAttachment.h"

@implementation WBEmotionTextView
-(void)insertEmotion:(WBEmotion *)emotion{
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
    }else if (emotion.png){
        WBEmotionAttachment *attch = [[WBEmotionAttachment alloc]init];
        attch.emotion = emotion;
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);
        //根据附件创建一个属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        //插入属性文字的光标的位置
        [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
    }
}
- (NSString *)fullText{
    NSMutableString *fullText = [NSMutableString string];
    //遍历所有的属性文字
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        WBEmotionAttachment *attch = attrs[@"NSAttachment"];
        if (attch) {//如果是图片
            [fullText appendString:attch.emotion.chs];
        }else{//如果是文字
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
    return fullText;
}
@end
