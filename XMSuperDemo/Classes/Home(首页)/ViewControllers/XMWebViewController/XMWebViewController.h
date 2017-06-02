//
//  XMWebViewController.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/1/6.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMWebViewDelegate <NSObject>

@optional

- (void)xm_webViewDidStartLoad:(UIWebView *)webView;
- (BOOL)xm_webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)xm_webViewDidFinishLoad:(UIWebView *)webView;
- (void)xm_webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end

@interface XMWebViewController : UIViewController


@property(nonatomic, weak) id<XMWebViewDelegate>XMDelegate;
@property(nonatomic, strong)UIColor *progressClolor;

-(instancetype)initWithUrl:(NSURL*)url;


@end






