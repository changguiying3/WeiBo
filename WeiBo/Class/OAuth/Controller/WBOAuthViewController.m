//
//  WBOAuthViewController.m
//  WeiBo
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBOAuthViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "WBAccountTool.h"


@interface WBOAuthViewController ()<UIWebViewDelegate>

@end

@implementation WBOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个webview
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    //client_id=2399444723  redirect_uri=
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2399444723&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.delegate = self;
   }
#pragma mark - webView代理方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
//    WBLog(@"webViewStartLoad");
    if (self.view == nil) {
        self.view = [[UIApplication sharedApplication].windows lastObject];
            }
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Loading.....";
    hud.removeFromSuperViewOnHide = YES;
    }
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //WBLog(@"webViewFinishLoad");
    if (self.view == nil) {
        self.view = [[UIApplication sharedApplication].windows lastObject];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (self.view == nil) {
        self.view = [[UIApplication sharedApplication].windows lastObject];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    //判断是否为回调地址
    if (range.length != 0) {
        NSInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}
-(void)accessTokenWithCode:(NSString *)code{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    /*
     URL：https://api.weibo.com/oauth2/access_token
     redirect_uri:http://www.baidu.com
     请求参数：
     client_id：申请应用时分配的AppKey
     client_secret：申请应用时分配的AppSecret
     grant_type：使用authorization_code
     redirect_uri：授权成功后的回调地址
     code：授权成功后返回的code
     */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2399444723";
    params[@"client_secret"] = @"1242e11f94a2c3d25dd75f61bd6bef77";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.baidu.com";
    params[@"code"] = code;
    //发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //WBLog(@"请求成功--%@",responseObject);
        if (self.view == nil) {
            self.view = [[UIApplication sharedApplication].windows lastObject];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //字典转模型
        WBAccount *account = [WBAccount accountWithDict:responseObject];
        //存入沙盒帐号信息
        [WBAccountTool saveAccount:account];
        //切换窗口根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WBLog(@"请求失败--%@",error);
        
        if (self.view == nil) {
            self.view = [[UIApplication sharedApplication].windows lastObject];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
 }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
