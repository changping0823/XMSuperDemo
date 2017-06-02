//
//  XMNavigationController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/3/31.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMNavigationController.h"

@interface XMNavigationController ()

@end

@implementation XMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count==1) {
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }
    [super pushViewController:viewController animated:animated];
}


@end
