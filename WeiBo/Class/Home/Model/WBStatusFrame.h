//
//  WBStatusFrame.h
//  WeiBo
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WBStatusCellNameFont [UIFont systemFontOfSize:15]
#define WBStatusCellTimeFont [UIFont systemFontOfSize:12]
#define WBStatusCellSourceFont WBStatusCellTimeFont
#define WBStatusCellContentFont [UIFont systemFontOfSize:14]
@class WBStatus;
@interface WBStatusFrame : NSObject
@property (nonatomic, strong) WBStatus *status;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
