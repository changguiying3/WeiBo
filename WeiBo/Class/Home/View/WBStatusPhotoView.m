//
//  WBStatusPhotoView.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBStatusPhotoView.h"
#import "WBPhoto.h"
#import "UIImageView+WebCache.h"

@interface WBStatusPhotoView ()
@property (nonatomic,weak) UIImageView *gitView;
@end
@implementation WBStatusPhotoView
-(UIImageView *)gitView{
    if (!_gitView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gitView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:gitView];
        self.gitView = gitView;
    }
    return _gitView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        //超出边框进行剪裁
        self.clipsToBounds = YES;
    }
    return self;
}
-(void)setPhoto:(WBPhoto *)photo{
    _photo = photo;
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    //判断是否是gif结尾，首先转换成小写
    self.gitView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}
//设置子控件的属性
-(void)layoutSubviews{
    [super layoutSubviews];
    self.gitView.x = self.width - self.gitView.width;
    self.gitView.y = self.height - self.gitView.height;
}
@end
