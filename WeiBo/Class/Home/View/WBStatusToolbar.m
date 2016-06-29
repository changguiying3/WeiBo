//
//  WBStatusToolbar.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBStatusToolbar.h"
#import "WBStatus.h"

@interface WBStatusToolbar ()
/**存放所有按钮*/
@property (nonatomic,strong) NSMutableArray *btns;
/**存放所有的分割线*/
@property (nonatomic,strong) NSMutableArray *dividers;
@property (nonatomic,weak) UIButton *repostBtn;
@property (nonatomic,weak) UIButton *commentBtn;
@property (nonatomic,weak) UIButton *attitudeBtn;
@end
@implementation WBStatusToolbar
-(NSMutableArray *)btns{
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}
-(NSMutableArray *)dividers{
    if (!_dividers) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}
+(instancetype)toolbar{
    return [[self alloc]init];
}
/**
 *  添加分割线
 */
-(void)setupDivider{
    UIImageView *divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        //add button
        self.repostBtn = [self  setupBtn:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self  setupBtn:@"评论" icon:@"timeline_icon_comment"];
        self.attitudeBtn = [self  setupBtn:@"赞" icon:@"timeline_icon_unlike"];
        //add divider
        [self setupDivider];
        [self setupDivider];
   }
    return self;
}
/**
 *  初始化一个按钮
 *
 *  @param title 按钮的名称
 *  @param icon  按钮的图片
 *
 *  @return 按钮
 */
-(UIButton *)setupBtn:(NSString *)title icon:(NSString *)icon{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}
/**
 *  set frame
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    //set btn of frame
    NSUInteger btnCount = self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i=0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
    //set 分割线的frame
    NSUInteger dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) * btnW;
    }
}
-(void)setStatus:(WBStatus *)status{
    _status = status;
//        status.reposts_count = 580456; // 58.7万
//        status.comments_count = 100004; // 10万
//        status.attitudes_count = 604; // 604
    //retweet
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    //comment
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    //attitude
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
    
    
}
-(void)setupBtnCount:(NSUInteger)count btn:(UIButton *)btn title:(NSString *)title{
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%ld",count];
            
        }else{
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
@end
