//
//  XMTabBarController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/3/31.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMTabBarController.h"
#import "XMHomeViewController.h"
#import "XMDiscoverViewController.h"
#import "XMVIPViewController.h"
#import "XMMyViewController.h"
#import "XMNavigationController.h"

@interface XMTabBarController ()


@end

@implementation XMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    XMHomeViewController * homeVC = [[XMHomeViewController alloc]init];
    XMDiscoverViewController * discoverVC = [[XMDiscoverViewController alloc]init];
    XMVIPViewController * vipVC = [[XMVIPViewController alloc]init];
    XMMyViewController * myVC = [[XMMyViewController alloc]init];
    
    
    [self addChildVc:homeVC title:@"俺搜" image:@"首页_黑" selectedImage:@"首页_on"];
    [self addChildVc:discoverVC title:@"发现" image:@"发现_黑" selectedImage:@"发现_on"];
    [self addChildVc:vipVC title:@"我的" image:@"VIP_黑" selectedImage:@"VIP_on"];
    [self addChildVc:myVC title:@"我的" image:@"我的_黑" selectedImage:@"我的_on"];

}


- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = XMColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
//    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor xm_MainColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    XMNavigationController * nav = [[XMNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
