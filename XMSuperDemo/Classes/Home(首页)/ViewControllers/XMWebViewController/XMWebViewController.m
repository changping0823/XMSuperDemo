//
//  XMWebViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/1/6.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMWebViewController.h"
#import "NJKWebViewProgress.h"




@interface XMWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property(nonatomic, strong)UIWebView *xm_WebView;

@property (nonatomic, strong)NJKWebViewProgress* progressProxy;


@property (nonatomic, assign) BOOL uiWebViewIsLoading;
@property (nonatomic, strong) NSURL *uiWebViewCurrentURL;
@property (nonatomic, strong) NSURL *URLToLaunchWithPermission;


@property (nonatomic, strong) UIProgressView *progressView;

@property(nonatomic, strong)NSURL *web_url;

@property (nonatomic, strong) NSTimer *fakeProgressTimer;

@property(nonatomic, assign)BOOL xm_canGoBack;

/**
 返回按钮
 */
@property(nonatomic, strong)UIBarButtonItem *backButtonItem;
/**
 关闭按钮
 */
@property(nonatomic, strong)UIBarButtonItem *closeButtonItem;

@end

@implementation XMWebViewController

-(instancetype)initWithUrl:(NSURL*)url{
    if ([super init]) {
        self.web_url = url;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationItem];

    
    [self.view addSubview:self.xm_WebView];
    [self.xm_WebView loadRequest:[NSURLRequest requestWithURL:self.web_url]];

    [self.view addSubview:self.progressView];
    
    
}



-(void)setNavigationItem{
    if (self.xm_WebView.canGoBack) {
        self.xm_canGoBack = YES;
        [self.navigationItem setLeftBarButtonItems:@[self.backButtonItem,self.closeButtonItem] animated:NO];
    }else{
        self.xm_canGoBack = NO;
        [self.navigationItem setLeftBarButtonItems:@[self.backButtonItem] animated:NO];
    }
}

-(void)setProgressClolor:(UIColor *)progressClolor{
    _progressClolor = progressClolor;
    self.progressView.tintColor = _progressClolor;
}



#pragma mark - UIWebViewDelegate


/**
 * 准备加载内容时调用的方法，通过返回值来进行是否加载的设置
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlString = [[request URL] absoluteString];
    NSLog(@"urlString == %@",urlString);
    
    if ([self.XMDelegate respondsToSelector:@selector(xm_webView:shouldStartLoadWithRequest:navigationType:)]) {
        [self.XMDelegate xm_webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    [self setNavigationItem];

    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    if ([self.XMDelegate respondsToSelector:@selector(xm_webViewDidStartLoad:)]) {
        [self.XMDelegate xm_webViewDidStartLoad:webView];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if ([self.XMDelegate respondsToSelector:@selector(xm_webViewDidFinishLoad:)]) {
        [self.XMDelegate xm_webViewDidFinishLoad:webView];
    }
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if ([self.XMDelegate respondsToSelector:@selector(xm_webView:didFailLoadWithError:)]) {
        [self.XMDelegate xm_webView:webView didFailLoadWithError:error];
    }

}


- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{

    
    NSLog(@"progress == %f",progress);
    
    [self.progressView setProgress:progress animated:YES];
    
    if (progress == 1.0) {
        [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.progressView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [self.progressView setProgress:0.0f animated:NO];
        }];
    }else{
        [self.progressView setAlpha:1.0f];
    }
    

}




- (void)loadRequest:(NSURLRequest *)request {
    [self.xm_WebView loadRequest:request];
}

- (void)loadURL:(NSURL *)URL {
    [self loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)loadURLString:(NSString *)URLString {
    NSURL *URL = [NSURL URLWithString:URLString];
    [self loadURL:URL];
}




-(void)closeButtonItemClick{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)backButtonItemClick{
    
    
    if (self.xm_canGoBack) {
        [self.xm_WebView goBack];
    }else{
        [self closeButtonItemClick];
    }
    
}







-(UIBarButtonItem*)closeButtonItem{
    if (!_closeButtonItem) {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonItemClick)];
    }
    return _closeButtonItem;
}

-(UIBarButtonItem*)backButtonItem{
    if (!_backButtonItem) {
        _backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonItemClick)];
    }
    return _backButtonItem;
}


-(UIWebView *)xm_WebView{
    if (!_xm_WebView) {
        _xm_WebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _xm_WebView.delegate = self.progressProxy;
    }
    return _xm_WebView;
}
-(UIProgressView *)progressView{
    if (!_progressView) {
        
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.trackTintColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
        _progressView.tintColor = [UIColor colorWithRed:0.400 green:0.863 blue:0.133 alpha:1.000];
        //设置进度条颜色
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

        _progressView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.progressView.frame.size.height);
        
    }
    return _progressView;
}

-(NJKWebViewProgress*)progressProxy{
    if (!_progressProxy) {
        _progressProxy = [[NJKWebViewProgress alloc] init];
        _progressProxy.webViewProxyDelegate = (id)self;
        _progressProxy.progressDelegate = (id)self;
    }
    return _progressProxy;
}



#pragma mark - Dealloc

- (void)dealloc {
    self.xm_WebView.delegate = nil;
    
}




@end







