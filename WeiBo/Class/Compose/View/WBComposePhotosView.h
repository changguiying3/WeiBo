//
//  WBComposePhotosView.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBComposePhotosView : UIView
-(void)addPhoto:(UIImage *)photo;
@property(nonatomic,strong,readonly) NSMutableArray *photos;

@end
