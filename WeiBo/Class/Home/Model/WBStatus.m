//
//  WBStatus.m
//  WeiBo
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBStatus.h"
#import "MJExtension.h"
#import "WBPhoto.h"
#import "WBUser.h"
#import "WBTextPart.h"
#import "WBEmotion.h"
#import "WBEmotionTool.h"
#import "RegexKitLite.h"


@implementation WBStatus
-(NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[WBPhoto class]};
}
/**
 *  普通文字转化成属性文字
 *
 *  @return 属性文字
 */
- (NSAttributedString *)attributedTextWithText:(NSString *)text{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
    //表情规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    //@的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@",emotionPattern,atPattern,topicPattern,urlPattern];
    //遍历所有的特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        WBTextPart *part = [[WBTextPart alloc]init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    //遍历所有的非特殊文字
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        WBTextPart *part = [[WBTextPart alloc]init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    //系统是总是按照从小到大顺序排列对象
    [parts sortUsingComparator:^NSComparisonResult(WBTextPart *part1, WBTextPart *part2) {
        if (part1.range.location > part1.range.location) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
    UIFont *font = [UIFont systemFontOfSize:15];
    //按顺序拼接每一段文字
    for (WBTextPart *part in parts) {
        NSAttributedString *substr = nil;
        if (part.isEmotion) {
            NSTextAttachment *attch = [[NSTextAttachment alloc]init];
            NSString *name = [WBEmotionTool emotionWithChs:part.text].png;
            if (name) {//能找到对应得图片
                attch.image = [UIImage imageNamed:name];
                attch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                substr = [NSAttributedString attributedStringWithAttachment:attch];
            }else{
                substr = [[NSAttributedString alloc]initWithString:part.text];
            }
        }else if (part.text){
            substr = [[NSAttributedString alloc]initWithString:part.text];
        }else{
            substr = [[NSAttributedString alloc]initWithString:part.text];
        }
        [attributedText appendAttributedString:substr];
    }
    //设置字体保证算出来的尺寸是正确的
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    return attributedText;
}
-(void)setText:(NSString *)text{
    _text = [text copy];
    self.attributedText = [self attributedTextWithText:text];
}
-(void)setRetweeted_status:(WBStatus *)retweeted_status{
    _retweeted_status = retweeted_status;
    NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status.user.name,retweeted_status.text];
    self.retweetedAttributedText = [self attributedTextWithText:retweetContent];
}
-(NSString *)created_at{
    // dateFormat == EEE MMM dd HH:mm:ss Z yyyy
    // NSString --> NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyy";
    NSDate *createDate = [fmt dateFromString:_created_at];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //枚举想要获得的差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    //WBLog(@"%@ %@ %@",createDate,now,cmps);
    if ([createDate isThisYear]) {
        if ([createDate isYesterday]) {
           fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }else if([createDate isToday]){
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            }else if(cmps.minute >= 1){
                return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
        }else{
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    }else{
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    
}
 //source == <a href="http://app.weibo.com/t/feed/2llosp" rel="nofollow">OPPO_N1mini</a>
-(void)setSource:(NSString *)source{
    NSRange range;
    //_source = source;
    if (![source isEqualToString:@""]) {
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        //range.length = [source rangeOfString:@"<" options:NSBackwardsSearch];
        _source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
    }
}

@end
