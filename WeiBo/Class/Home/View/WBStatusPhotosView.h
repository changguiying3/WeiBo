//
//  WBStatusPhotoView.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBStatusPhotosView : UIView
@property(nonatomic,strong) NSArray *photos;
/**
 *  根据图片个数计算相册尺寸
 */
+(CGSize)sizeWithCount:(NSUInteger)count;
@end
