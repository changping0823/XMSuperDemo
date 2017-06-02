//
//  XMTestViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2016/11/18.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "XMTestViewController.h"
#import "UIButton+XMExtension.h"
#import "XMTestView.h"
#import "XMWebViewController.h"
@interface XMTestViewController ()<XMWebViewDelegate>
@property (nonatomic, strong) XMTestView *testView;


@end

@implementation XMTestViewController

-(instancetype)init{
    return [self initWithUrl:[NSURL URLWithString:@"http://www.baidu.com"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.XMDelegate = self;
    self.hidesBottomBarWhenPushed = YES;
//    self.
    
}


-(void)xm_webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"XMTestViewController ---->> didFailLoadWithError");
}

-(void)xm_webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"XMTestViewController ---->>webViewDidFinishLoad");
}

-(void)xm_webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"XMTestViewController ---->>webViewDidStartLoad");
}

-(BOOL)xm_webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"XMTestViewController ---->>shouldStartLoadWithRequest");
    
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
}

-(void)dealloc{
    NSLog(@"XMTestViewController  ---  dealloc");
}

@end
