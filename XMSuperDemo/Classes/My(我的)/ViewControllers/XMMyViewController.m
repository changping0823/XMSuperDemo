//
//  XMMyViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2016/11/18.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "XMMyViewController.h"
#import "UITextField+Extension.h"
#import "UIImage+XMExtension.h"


static NSString *const TestBURL = @"mqq://im/chat?chat_type=wpa&uin=993195264&version=1&src_type=web";

//打开QQ聊天界面（993195264：QQ账号）
//static NSString *const TestBURL = @"mqq://im/chat?chat_type=wpa&uin=993195264&version=1&src_type=web";


@interface XMMyViewController ()
@property (nonatomic, strong) NSMutableArray *views;
@property(nonatomic, strong)UITextField *textField;
@property(nonatomic, strong)UIWebView *webView;

@end

@implementation XMMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc]init];
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://appnew.antsoo.com:82/entryCompany.html"]]];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
//    UIImage * image = [UIImage imageNamed:@"filter"];
//    [image circleImage];
//    
//    UIImageView * imageView = [[UIImageView alloc]init];
//    [self.view addSubview:imageView];
//    imageView.image = image;
//    
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(200, 200));
//        make.left.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.view).offset(64);
//    }];
//    
//    self.textField = [[UITextField alloc]init];
////    self.textField.showKeyboardTool = YES;
//    self.textField.backgroundColor = [UIColor RandomColor];
//    [self.view addSubview:self.textField];
//    
//    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(200, 40));
//        make.center.mas_equalTo(self.view);
//    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.textField resignFirstResponder];
    [self.view endEditing:YES];
    
    NSURL *url = [NSURL URLWithString:TestBURL];
    BOOL result = [[UIApplication sharedApplication] canOpenURL:url];
    
//    if (result == YES) {
    
        [[UIApplication sharedApplication] openURL:url];
        
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
