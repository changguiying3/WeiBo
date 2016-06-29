//
//  WBHomeViewController.m
//  WeiBo
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBHomeViewController.h"
#import "WBTitleMenuViewController.h"
#import "WBDropdownMenu.h"
#import "AFNetworking.h"
#import "WBAccountTool.h"
#import "WBTitleButton.h"
#import "WBUser.h"
#import "WBStatus.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "WBLoadMoreFooter.h"
#import "WBStatusFrame.h"
#import "WBStatusCell.h"

@interface WBHomeViewController ()<WBDropdownMenuDelegate>
/**
 *  微博数组
 */
@property(nonatomic,strong) NSMutableArray *statusFrame;
@end

@implementation WBHomeViewController

-(NSMutableArray *)statusFrame{
    if (!_statusFrame) {
        self.statusFrame = [NSMutableArray array];
    }
    return _statusFrame;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = WBColor(211, 211, 211);
    //设置导航栏
    [self setNavigation];
    //获得用户信息
    [self setupUserInfo];
    //集成刷新控件
    [self setupDownRefresh];
    //上拉刷新
    [self setupUpRefresh];
    //获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}
/**
 *  将status模型转换成statusFrame模型
 */
-(NSArray *)statusFramesWithStatuses:(NSArray *)statuses{
    NSMutableArray *frames = [NSMutableArray array];
    for (WBStatus *status in statuses) {
        WBStatusFrame *f = [[WBStatusFrame alloc]init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}
-(void)setupUnreadCount{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    WBAccount *account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    //发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            float version = [[[UIDevice currentDevice]systemVersion]floatValue];
            if (version >= 8.0) {
                UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
                [[UIApplication sharedApplication]registerUserNotificationSettings:settings];
                [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            }else{
                [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            }
        }else{
            self.tabBarItem.badgeValue = status;
            float version = [[[UIDevice currentDevice]systemVersion]floatValue];
            
            if (version >= 8.0) {
                UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
                [[UIApplication sharedApplication]registerUserNotificationSettings:settings];
                [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
                
            }else{
                [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WBLog(@"readCount failure --%@",error);
    }];
}
-(void)setupUpRefresh{
    WBLoadMoreFooter *footer = [WBLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
    
}
-(void)loadMoreStatus{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    WBAccount * account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出微博的最后一台数据
     WBStatusFrame *lastStatus = [self.statusFrame lastObject];
    if (lastStatus) {
        long long maxId = lastStatus.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典转模型
        NSArray *newStatuses = [WBStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        //将更多的微博数据添加到总数组的最后面
        [self.statusFrame addObjectsFromArray:newFrames];
        [self.tableView reloadData];
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WBLog(@"loadMore failure--%@",error);
        self.tableView.tableFooterView.hidden = YES;
    }];
}
-(void)setupDownRefresh{
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    //自动刷新
    [control beginRefreshing];
    //自动调用方法，刷新数据
    [self refreshStateChange:control];
}
-(void)refreshStateChange:(UIRefreshControl *)control{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    WBAccount *account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出第一条微博数据
    WBStatusFrame *firstStatus = [self.statusFrame firstObject];
    if (firstStatus) {
        params[@"since_id"] = firstStatus.status.idstr;
    }
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //WBLog(@"WeiBo-- success%@",responseObject);
        //字典转模型
        NSArray *newStatuses = [WBStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        //将最新加载出来的数据加载在数组的最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrame insertObjects:newFrames atIndexes:set];
        //刷新列表
        [self.tableView reloadData];
        [control endRefreshing];
        [self showNewStatusCount:newFrames.count];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WBLog(@"WeiBo-- failure%@",error);
        [control endRefreshing];
    }];
    //WBLog(@"Loading success----");
}
/**
 *  显示最新微博的数量
 */
-(void)showNewStatusCount:(NSInteger)count{
    //创建一个label
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    //设置其它的属性
    if (count == 0) {
        label.text = @"没有最新的消息，稍后再试";
    }else{
        label.text = [NSString stringWithFormat:@"%ld条新的微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    //添加label到导航栏下面
    label.y = 64 - label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    //label以动画的形式显示
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear  animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}
-(void)setNavigation{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(fetch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlight"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlight"];
    /*设置中间的文字*/
    WBTitleButton *titleButton = [[WBTitleButton alloc]init];
    NSString *name = [WBAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    self.navigationItem.titleView = titleButton;
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setupUserInfo{
    
    //请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //拼接参数
    WBAccount *account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      //WBTitleButton *titleButton = (WBTitleButton*)self.navigationItem.titleView;
        NSString *name = responseObject[@"name"];
        //[titleButton setTitle:name forState:UIControlStateNormal];
        //将获得的昵称存入沙盒内
        account.name = name;
        [WBAccountTool saveAccount:account];
        //WBLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WBLog(@"%@",error);
    }];
}
-(void)fetch{
    WBLog(@"friends");
}
-(void)pop{
    WBLog(@"pop");
}
#pragma --实现销毁代理方法
-(void)dropdownMenuDidDismiss:(WBDropdownMenu *)menu{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
    //    WBLog(@"111");
}
#pragma --实现现实代理方法
-(void)dropdownMenuDidShow:(WBDropdownMenu *)menu{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
    //    WBLog(@"222");
}
-(void)titleClick:(UIButton *)titleButton{
    WBDropdownMenu *menu = [WBDropdownMenu menu];
    menu.delegate = self;
    WBTitleMenuViewController *vc = [[WBTitleMenuViewController alloc]init];
    vc.view.height = 150;
    vc.view.width = 150;
    menu.contentController = vc;
    [menu showFrom:titleButton];
}
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusFrame.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrame[indexPath.row];
    return cell;
    }
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //tableView没有数据时，直接返回
    if (self.statusFrame.count == 0 || self.tableView.tableFooterView.hidden == NO) return;
    CGFloat offsetY = scrollView.contentOffset.y;
    //当最后一个cell完全显示在眼前时，contentOffset.y的值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) {//最后一个cell完全进入视野范围内
        self.tableView.tableFooterView.hidden = YES;
        [self loadMoreStatus];
    }
        
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WBStatusFrame *frame = self.statusFrame[indexPath.row];
    return frame.cellHeight;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
