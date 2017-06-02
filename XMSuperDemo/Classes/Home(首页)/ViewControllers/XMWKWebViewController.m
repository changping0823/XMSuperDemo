//
//  XMWKWebViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/12.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMWKWebViewController.h"
#import <WebKit/WebKit.h>


static void *WkwebBrowserContext = &WkwebBrowserContext;

@interface XMWKWebViewController ()<WKNavigationDelegate>
@property(nonatomic, strong)WKWebView *wkWebView;
//设置加载进度条
@property (nonatomic,strong) UIProgressView *progressView;

//返回按钮
@property (nonatomic)UIBarButtonItem* customBackBarItem;
//关闭按钮
@property (nonatomic)UIBarButtonItem* closeButtonItem;

@end

@implementation XMWKWebViewController

-(void)updateNavigationItems{
    if (self.wkWebView.canGoBack) {
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem,self.closeButtonItem] animated:NO];
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
    }
}

-(instancetype)initWithUrlStr:(NSString *)urlStr{
    self.urlString = urlStr;
    return [self initWithUrl:[NSURL URLWithString:self.urlString]];
}
-(instancetype)initWithUrl:(NSURL*)url{
    if ([super init]) {
        self.webUrl = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
    
    [self.view addSubview:self.wkWebView];
    NSURL * webUrl = [NSURL URLWithString:self.urlString];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:webUrl]];
    
    //添加进度条
    [self.view addSubview:self.progressView];
}



#pragma mark - WKNavigationDelegate

//这个是网页加载完成，导航的变化
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.title = self.wkWebView.title;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateNavigationItems];
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {

}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"absoluteString == %@",navigationAction.request.URL.absoluteString);
    
    decisionHandler(WKNavigationActionPolicyAllow);

}

//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - 点击事件
-(void)closeItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)customBackItemClicked{
    if (self.wkWebView.goBack) {
        [self.wkWebView goBack];
    }else{
        [self closeItemClicked];
    }
}






#pragma mark - get   set 

-(void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
    self.webUrl = [NSURL URLWithString:_urlString];
}
-(void)setWebUrl:(NSURL *)webUrl{
    _webUrl = webUrl;
}


#pragma mark - 懒加载

-(WKWebView *)wkWebView{
    if (!_wkWebView) {
        WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
        _wkWebView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configuration];
        _wkWebView.navigationDelegate = self;
        //kvo 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
    }
    return _wkWebView;
}
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        
        _progressView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 3);
        
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}

-(UIBarButtonItem*)customBackBarItem{
    if (!_customBackBarItem) {
        UIImage* backItemImage = [[UIImage imageNamed:@"btn_backItem"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIButton* backButton = [[UIButton alloc] init];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [backButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [backButton setImage:backItemImage forState:UIControlStateNormal];
        [backButton sizeToFit];
        
        [backButton addTarget:self action:@selector(customBackItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _customBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _customBackBarItem;
}
-(UIBarButtonItem*)closeButtonItem{
    if (!_closeButtonItem) {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClicked)];
    }
    return _closeButtonItem;
}


//注意，观察的移除
-(void)dealloc{
    NSLog(@"XMWKWebViewController ---- dealloc");
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

@end














