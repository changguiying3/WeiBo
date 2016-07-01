//
//  WBStatusFrame.m
//  WeiBo
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "WBStatusPhotosView.h"

#define WBStatusCellBorderW 10
@implementation WBStatusFrame
//-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW{
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = font;
//    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
//    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//}
//-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font{
//    return [self sizeWithText:text font:font maxW:MAXFLOAT];
//}
-(void)setStatus:(WBStatus *)status{
    _status = status;
    WBUser *user = status.user;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    /**设置头像*/
    CGFloat iconWH = 35;
    CGFloat iconX = WBStatusCellBorderW;
    CGFloat iconY = WBStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    /**设置昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + WBStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:WBStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    /**会员图标的frame*/
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + WBStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    /** 时间的frame */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + WBStatusCellBorderW;
//    CGSize timeSize = [self sizeWithText:status.created_at font:WBStatusCellTimeFont];
    CGSize timeSize = [status.created_at sizeWithFont:WBStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    /** 来源的frame */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + WBStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:WBStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    /** 正文的frame */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + WBStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [status.text sizeWithFont:WBStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    /** 配图的frame */
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + WBStatusCellBorderW;
        CGSize photosSize = [WBStatusPhotosView sizeWithCount:status.pic_urls.count];
        self.photosViewF = (CGRect){{photoX,photoY},photosSize};
        originalH = CGRectGetMaxY(self.photosViewF) + WBStatusCellBorderW;
    }else{
         originalH = CGRectGetMaxY(self.contentLabelF) + WBStatusCellBorderW;
    }
    /** 原创微博的frame */
    CGFloat originalX = 0;
    CGFloat originalY = WBstatusCellMargin;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    self.cellHeight = CGRectGetMaxY(self.originalViewF);
    /** 被转发微博 */
    CGFloat toolbarY = 0;
    if (status.retweeted_status) {
        WBStatus *reweeted_status = status.retweeted_status;
        WBUser *reweeted_user = reweeted_status.user;
        CGFloat retweetContentX = WBStatusCellBorderW;
        CGFloat retweetContentY = WBStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",reweeted_user.name,reweeted_status.text];
        CGSize retweetContentSize = [retweetContent sizeWithFont:WBStatusCellReweetContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        CGFloat retweetH = 0;
        if (reweeted_status.pic_urls.count) {
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + WBStatusCellBorderW;
            CGSize retweetPhotoSize = [WBStatusPhotosView sizeWithCount:reweeted_status.pic_urls.count];
            self.reweetPhotoF = (CGRect){{retweetPhotoX, retweetPhotoY}, retweetPhotoSize};
            retweetH = CGRectGetMaxY(self.reweetPhotoF) + WBStatusCellBorderW;
        }else{
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + WBStatusCellBorderW;
        }
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        toolbarY = CGRectGetMaxY(self.retweetF);
        
    }else{
        
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    /** toolBar */
    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    /** cell height*/
    self.cellHeight = CGRectGetMaxY(self.toolbarF);
 
}
@end
