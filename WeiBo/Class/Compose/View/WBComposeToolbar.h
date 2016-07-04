//
//  WBComposeToolbar.h
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WBComposeToolbarButtonTypeCamera, // 拍照
    WBComposeToolbarButtonTypePicture, // 相册
    WBComposeToolbarButtonTypeMention, // @
    WBComposeToolbarButtonTypeTrend, // #
    WBComposeToolbarButtonTypeEmotion // 表情
}WBComposeToolbarButtonType;
@class WBComposeToolbar;
@protocol WBComposeToolbarDelegate <NSObject>

@optional
-(void)composeToolbar:(WBComposeToolbar *)toolbar didClickButton:(WBComposeToolbarButtonType)buttonType;

@end

@interface WBComposeToolbar : UIView
@property (nonatomic,weak) id<WBComposeToolbarDelegate> delegate;
/** 是否显示键盘按钮 */
@property (nonatomic,assign) BOOL showKeyboardButton;
@end
