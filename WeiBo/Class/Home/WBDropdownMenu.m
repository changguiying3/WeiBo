//
//  WBDropdownMenu.m
//  WeiBo
//
//  Created by mac on 16/5/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBDropdownMenu.h"

@interface WBDropdownMenu()
@property (nonatomic,weak) UIImageView *containerView;
@end

@implementation WBDropdownMenu
/**
 *  懒加载灰色视图
 *
 * */
-(UIImageView *)containerView{
    if (!_containerView) {
        UIImageView *containerView = [[UIImageView alloc]init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
+(instancetype)menu{
    return [[self alloc]init];
}
/**
 *  设置灰色视图的内容和位置
 *
 * */
-(void)setContent:(UIView *)content{
    _content = content;
    content.x = 10;
    content.y = 15;
    self.containerView.height = CGRectGetMaxY(content.frame) + 11;
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    [self.containerView addSubview:content];
}
/**
 *  获得内容的控制器
 *
 *
 */
-(void)setContentController:(UIViewController *)contentController{
    _contentController = contentController;
    self.content = contentController.view;
}
/**
 *  设置灰色图片的位置
 *
 *
 */
-(void)showFrom:(UIView *)from{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    self.frame = window.bounds;
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.y = CGRectGetMaxY(newFrame);
    self.containerView.centerX = CGRectGetMidX(newFrame);
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}
/**
 *  销毁
 */
-(void)dismiss{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
@end
