//
//  WBEmotionListView.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/7/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBEmotionListView.h"
#import "WBEmotionPageView.h"

@interface WBEmotionListView ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIPageControl *pageControl;
@end
@implementation WBEmotionListView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //UIscrollView
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        //pageControl
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.userInteractionEnabled = NO;
        //设置圆点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}
-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    //删除之前的控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSUInteger count = (emotions.count + WBEmotionPageSize - 1)/WBEmotionPageSize;
    //设置页数
    self.pageControl.numberOfPages = count;
    //将表情分页对应
    for (int i = 0; i<count; i++) {
        WBEmotionPageView *pageView = [[WBEmotionPageView alloc]init];
        NSRange range;
        range.location = i * WBEmotionPageSize;
        NSUInteger left = emotions.count - range.location;
        if (left >= WBEmotionPageSize) {
            range.length = WBEmotionPageSize;
        }else{
            range.length = left;
        }
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    [self setNeedsLayout];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 25;
    self.pageControl.y = self.height - self.pageControl.height;
    self.pageControl.x = 0;
    // scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    //设置scrollView的每一页尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i<count; i++) {
        WBEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = i * pageView.width;
        pageView.y = 0;
        //pageView.backgroundColor = [UIColor blueColor];
    }
    //设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}
#pragma mark-scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
}
@end
