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
        UIView *originalView = [[UIView alloc]init];
        [self.contentView addSubview:originalView];
        self.originalView = originalView;
        
        UIImageView *iconView = [[UIImageView alloc]init];
        [originalView addSubview:iconView];
        self.iconView = iconView;
        
        UIImageView *vipView = [[UIImageView alloc]init];
        [originalView addSubview:vipView];
        self.iconView = vipView;
        
        UIImageView *photoView = [[UIImageView alloc]init];
        [originalView addSubview:photoView];
        self.iconView = photoView;
        
        UILabel *nameLable = [[UILabel alloc]init];
        [originalView addSubview:nameLable];
        self.nameLabel = nameLable;
        
        UILabel *timeLabel = [[UILabel alloc]init];
        [originalView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *sourceLabel = [[UILabel alloc]init];
        [originalView addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        UILabel *contentLabel = [[UILabel alloc]init];
        [originalView addSubview:contentLabel];
        self.contentLabel = contentLabel;
    }
    return self;
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
        self.vipView.hidden = YES;
    }
    self.photoView.frame = statusFrame.photoViewF;
    self.photoView.backgroundColor = [UIColor redColor];
    
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
}
@end
