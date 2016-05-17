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

@interface WBHomeViewController ()<WBDropdownMenuDelegate>


@end

@implementation WBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self setupUserInfo];
   
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setNavigation{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(fetch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlight"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlight"];
    /*设置中间的文字*/
    WBTitleButton *titleButton = [[WBTitleButton alloc]init];
    NSString *name = [WBAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    //[titleButton sizeToFit];
//    titleButton.width = 200;
//    titleButton.height = 30;
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
        WBLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WBLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
-(void)fetch{
    WBLog(@"friends");
}
-(void)pop{
    WBLog(@"pop");
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
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
