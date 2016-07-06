//
//  WBComposeViewController.m
//  WeiBo
//
//  Created by 常桂盈的Mac on 16/6/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBAccountTool.h"
#import "WBTextView.h"
#import "WBComposeToolbar.h"
#import "WBEmotionKeyboard.h"

@interface WBComposeViewController ()<UITextViewDelegate,WBComposeToolbarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** 输入控件 */
@property (nonatomic,weak) WBTextView *textView;
/** 输入键盘顶部的工具条 */
@property (nonatomic,weak) WBComposeToolbar *toolbar;
/** 表情键盘 */
//一定要用strong
@property(nonatomic,strong) WBEmotionKeyboard *emotionKeyboard;
/** 是否正在切换键盘*/
@property (nonatomic,assign) BOOL switchingKeyboard;
 
@end
@implementation WBComposeViewController
-(WBEmotionKeyboard *)emotionKeyboard{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[WBEmotionKeyboard alloc]init];
        //键盘的宽度
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;
    }
    return _emotionKeyboard;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    [self setupTextView];
    [self setupToolbar];
 }
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    NSString *name = [WBAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc]init];
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.numberOfLines = 0;
        titleView.y = 50;
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        //创建一个带有属性的字符串（可以设置字体的颜色和属性）
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        //添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:[str rangeOfString:name]];
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
        
    }else{
        self.title = prefix;
    }
}
-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)send{
    [self dismissViewControllerAnimated:YES completion:nil];
   }
/**
 *  添加输入控件
 */
-(void)setupTextView{
    //因为是导航控制器的跟控制器，所以contentInset.top默认等于64
    WBTextView *textView = [[WBTextView alloc]init];
    //使它上下有弹簧效果，可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView = textView;
    //文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    // 键盘改变时，发出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
/**
 *  键盘的frame发生改变时进行调用
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    if (self.switchingKeyboard) return;
    NSDictionary *userInfo = notification.userInfo;
    //动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    //键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        if (keyboardF.origin.y > self.view.height) {
            self.toolbar.y = self.view.height - self.toolbar.height;
        }else{
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }
    }];
    }
/**
 *  添加工具条
 *
 */
- (void)setupToolbar{
    WBComposeToolbar *toolbar  = [[WBComposeToolbar alloc]init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height -toolbar.height;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}
/**
 *  监听文字改变
 */
-(void)textDidChange{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}
-(void)openCamera{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}
-(void)openAlbum{
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}
-(void)openImagePickerController:(UIImagePickerControllerSourceType)type{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
        }
/**
 *  切换键盘
 */
- (void)switchKeyboard{
    if (self.textView.inputView == nil) {
        self.textView.inputView = self.emotionKeyboard;
        //显示键盘按钮
        self.toolbar.showKeyboardButton = YES;
    }else{
        self.textView.inputView = nil;
        self.toolbar.showKeyboardButton = NO;
    }
    //开始切换键盘
        self.switchingKeyboard = YES;
    //退出键盘
    [self.textView endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
        //结束切换键盘
        self.switchingKeyboard = NO;
    });
    
}
#pragma mark - UITextViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark - WBComposeToolbarDelegate
-(void)composeToolbar:(WBComposeToolbar *)toolbar didClickButton:(WBComposeToolbarButtonType)buttonType{
    switch (buttonType) {
        case WBComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case WBComposeToolbarButtonTypePicture:
            [self openAlbum];
            break;
        case WBComposeToolbarButtonTypeEmotion://表情／键盘
            [self switchKeyboard];
            break;
        case WBComposeToolbarButtonTypeTrend:
            WBLog(@"----#");
            break;
        case WBComposeToolbarButtonTypeMention:
            WBLog(@"----@");
            break;
    }
}
@end
