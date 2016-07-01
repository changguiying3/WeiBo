//
//  WBIconView.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/6/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBIconView.h"
#import "WBUser.h"
#import "UIImageView+WebCache.h"

@interface WBIconView  ()
@property (nonatomic,weak) UIImageView *verifiedView;
@end
@implementation WBIconView
-(UIImageView *)verifiedView{
    if (!_verifiedView) {
        UIImageView *verifieedView = [[UIImageView alloc]init];
        [self addSubview:verifieedView];
        self.verifiedView = verifieedView;
    }
    return _verifiedView;
}
-(void)setUser:(WBUser *)user{
    _user = user;
    //下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //设置头像等级显示
    switch (user.verified_type) {
        case WBUserVerifiedPersonal:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case WBUserVerifiedOrgEnterprice:
        case WBUserVerifiedOrgMedia:
        case WBUserVerifiedOrgWebsite:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case WBUserVerifiedDaren:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            
        default:
            self.verifiedView.hidden = YES;
            break;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.verifiedView.size = self.verifiedView.image.size;
    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
}
@end
