//
//  WBStatusPhotoView.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBStatusPhotosView.h"
#import "WBPhoto.h"
#import "WBStatusPhotoView.h"

#define WBStatusPhotoWH 70
#define WBStatusPhotoMargin 10
#define WBStatusPhotoMaxCol(count) ((count == 4)?2:3)
@implementation WBStatusPhotosView
-(void)setPhotos:(NSArray *)photos{
    _photos = photos;
    while (self.subviews.count < photos.count) {
        WBStatusPhotoView *photoView = [[WBStatusPhotoView alloc]init];
        [self addSubview:photoView];
    }
    //遍历所有图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        WBStatusPhotoView *photoView = self.subviews[i];
        if (i<photos.count) {
            photoView.photo = photos[i];
            photoView.hidden = NO;
        }else{
            photoView.hidden = YES;
        }
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置图片的尺寸和位置
    NSInteger photosCount = self.photos.count;
    NSInteger maxCol = WBStatusPhotoMaxCol(photosCount);
    for (int i = 0; i<photosCount; i++) {
        WBStatusPhotosView *photoView = self.subviews[i];
        NSInteger col = i % maxCol;
        photoView.x = col * (WBStatusPhotoWH + WBStatusPhotoMargin);
        NSInteger row = i / maxCol;
        photoView.y = row * (WBStatusPhotoWH + WBStatusPhotoMargin);
        photoView.width = WBStatusPhotoWH;
        photoView.height = WBStatusPhotoWH;
    }
}
+(CGSize)sizeWithCount:(NSUInteger)count{
    //最大列数
    NSInteger maxcols = WBStatusPhotoMaxCol(count);
    NSInteger cols = (count >= maxcols) ? maxcols : count;
    CGFloat photosW = cols * WBStatusPhotoWH + (cols - 1) * WBStatusPhotoMargin;
    //最大行数
    NSInteger rows = (count + maxcols - 1) / maxcols;
    CGFloat photosH = rows * WBStatusPhotoWH + (rows - 1) * WBStatusPhotoMargin;
    return CGSizeMake (photosW,photosH);
}
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor = [UIColor redColor];
//    }
//    return self;
//}
@end
