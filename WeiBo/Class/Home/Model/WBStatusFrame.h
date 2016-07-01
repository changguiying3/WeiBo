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
#define WBStatusCellReweetContentFont [UIFont systemFontOfSize:13]
//cell之间的间距
#define WBstatusCellMargin 15
//cell的边框宽度
#define WBstatusCellBorderW 10
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
@property (nonatomic, assign) CGRect photosViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;
/** 转发微博的整体 */
@property(nonatomic,assign) CGRect retweetF;
/** 转发微博的正文*/
@property(nonatomic,assign) CGRect retweetContentLabelF;
/** 转发微博的配图*/
@property(nonatomic,assign) CGRect reweetPhotoF;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 底部工具条*/
@property (nonatomic,assign) CGRect toolbarF;
@end
