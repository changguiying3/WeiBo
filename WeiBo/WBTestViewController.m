//
//  WBTestViewController.m
//  WeiBo
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBTestViewController.h"
#import "WBTest1ViewController.h"
@interface WBTestViewController ()

@end

@implementation WBTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    WBTest1ViewController *test1VC = [[WBTest1ViewController alloc]init];
    test1VC.title = @"测试控制器2";
    [self.navigationController pushViewController:test1VC animated:YES];
}

@end
