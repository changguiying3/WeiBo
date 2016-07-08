//
//  WBComposePhotosView.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBComposePhotosView.h"

@implementation WBComposePhotosView
-(void)addPhoto:(UIImage *)photo{
    UIImageView *photoView = [[UIImageView alloc]init];
    photoView.image = photo;
    [self addSubview:photoView];
    //存储图片
    [self.photos addObject:photo];
    WBLog(@"%@",self.photos);
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    NSInteger maxCol = 4;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    for (int i = 0; i<count; i++) {
        UIImageView *photoView = self.subviews[i];
        NSInteger col = i % maxCol;
        photoView.x = col * (imageWH + imageMargin);
        NSInteger row = i / maxCol;
        photoView.y = row * (imageWH + imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;
    }
}
@end
