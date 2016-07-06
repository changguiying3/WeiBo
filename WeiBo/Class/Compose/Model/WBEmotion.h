//
//  WBEmotion.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBEmotion : NSObject
/** 表情文字描述 */
@property (nonatomic,copy) NSString *chs;
/** 表情的图片名描述 */
@property (nonatomic,copy) NSString *png;
/** emoji表情进行编码 */
@property (nonatomic,copy) NSString *code;
@end
