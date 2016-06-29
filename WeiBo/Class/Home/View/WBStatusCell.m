//
//  WBStatusCell.m
//  WeiBo
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBStatusCell.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "WBStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "WBPhoto.h"
#import "WBStatusToolbar.h"

@interface WBStatusCell ()
/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 转发微博的整体 */
@property(nonatomic,weak) UIView *retweetView;
/** 转发微博的正文*/
@property(nonatomic,weak) UILabel *retweetContentLabel;
/** 转发微博的配图*/
@property(nonatomic,weak) UIImageView *reweetPhotoView;
/** toolbar */
@property (nonatomic,weak) WBStatusToolbar *toolbar;
@end

@implementation WBStatusCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WBStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //点击cell的时候不要变颜色
        self.selectionStyle = UITableViewCellEditingStyleNone;
        [self setupOriginal];
        [self setupRetweet];
        [self setupToolbar];
    }
    return self;
}
/**
 *  init toolbar
 */
-(void)setupToolbar{
    WBStatusToolbar *toolbar = [WBStatusToolbar toolbar];
    [self.contentView addSubview:toolbar];
//    toolbar.backgroundColor = [UIColor redColor];
    self.toolbar = toolbar;
  }
/**
 *  初始化原创微博
 */

-(void)setupOriginal{
    UIView *originalView = [[UIView alloc]init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    UIImageView *iconView = [[UIImageView alloc]init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    UIImageView *vipView = [[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    
    UIImageView *photoView = [[UIImageView alloc]init];
    [originalView addSubview:photoView];
    self.photoView = photoView;
    
    UILabel *nameLable = [[UILabel alloc]init];
    nameLable.font = WBStatusCellNameFont;
    [originalView addSubview:nameLable];
    self.nameLabel = nameLable;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = WBStatusCellTimeFont;
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = WBStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = WBStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}
/**
 *  初始化转发微博
 */
-(void)setupRetweet{
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = WBColor(247, 247, 247);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.font = WBStatusCellReweetContentFont;
    retweetContentLabel.numberOfLines = 0;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    UIImageView *reweetPhotoView = [[UIImageView alloc]init];
    [retweetView addSubview:reweetPhotoView];
    self.reweetPhotoView = reweetPhotoView;
}
-(void)setStatusFrame:(WBStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    WBStatus *status = statusFrame.status;
    WBUser *user = status.user;
    self.originalView.frame = statusFrame.originalViewF;
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    if (status.pic_urls.count) {
        self.photoView.frame = statusFrame.photoViewF;
        WBPhoto *photo = [status.pic_urls firstObject];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden = NO;
    }else{
        self.photoView.hidden = YES;
    }
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    /**时间*/
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + WBstatusCellBorderW;
    CGSize timeSize = [time sizeWithFont:WBStatusCellTimeFont];
    self.timeLabel.text = time;
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    /** 来源*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + WBstatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:WBStatusCellSourceFont];
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    //self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    if (status.retweeted_status) {
        WBStatus *retweeted_status = status.retweeted_status;
        WBUser *retweeted_user = retweeted_status.user;
        /** 被转发的微博整体frame */
        self.retweetView.frame = statusFrame.retweetF;
        
        self.retweetView.hidden = NO;
        NSString *retweetedContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_user.name,retweeted_status.text];
        self.retweetContentLabel.text = retweetedContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        if (retweeted_status.pic_urls.count) {
            self.reweetPhotoView.frame = statusFrame.reweetPhotoF;
            WBPhoto *retweetPhoto = [retweeted_status.pic_urls firstObject];
            [self.reweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.reweetPhotoView.hidden = NO;
        }else{
            self.reweetPhotoView.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
   /** toolbar*/
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.status = status;
}

@end
