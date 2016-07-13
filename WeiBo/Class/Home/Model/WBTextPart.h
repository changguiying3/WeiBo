//
//  WBTextPart.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBTextPart : NSObject
/** 这段文字的内容*/
@property (nonatomic,copy) NSString *text;
/** 文字的范围*/
@property (nonatomic,assign) NSRange range;
/** 是否为特殊文字*/
@property (nonatomic,assign,getter=isSpecial) BOOL special;
/** 是否为特殊表情*/
@property (nonatomic,assign,getter=isEmotion) BOOL emotion;
@end
