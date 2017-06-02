//
//  XMWKWebViewController.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/12.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMWKWebViewController : UIViewController

@property(nonatomic, copy)NSString *urlString;
@property(nonatomic, strong)NSURL *webUrl;
-(instancetype)initWithUrlStr:(NSString*)urlStr;
-(instancetype)initWithUrl:(NSURL*)url;
@end
