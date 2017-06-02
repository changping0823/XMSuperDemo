//
//  XMHomeViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2016/11/18.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "XMHomeViewController.h"
#import "XMCitySearchViewController.h"
#import "XMSwipeViewController.h"
#import "XMDrawingViewController.h"
#import "XMMediaLibraryViewController.h"
#import "XMWKWebViewController.h"
#import "XMHTMLViewController.h"

NSString * const TestViewController         = @"XMTestViewController";
NSString * const CitySearchViewController   = @"XMCitySearchViewController";
NSString * const SwipeViewController        = @"XMSwipeViewController";
NSString * const DrawingViewController      = @"XMDrawingViewController";
NSString * const MediaLibraryViewController = @"XMMediaLibraryViewController";
NSString * const WKWebViewController        = @"XMWKWebViewController";
NSString * const HTMLViewController         = @"XMHTMLViewController";


@interface XMHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * viewControllers;


@end

@implementation XMHomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    [self.viewControllers addObject:TestViewController];
    [self.viewControllers addObject:CitySearchViewController];
    [self.viewControllers addObject:SwipeViewController];
    [self.viewControllers addObject:DrawingViewController];
    [self.viewControllers addObject:MediaLibraryViewController];
    [self.viewControllers addObject:WKWebViewController];
    [self.viewControllers addObject:HTMLViewController];
    [self.view addSubview:self.tableView];


}

#pragma mark -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewControllers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.viewControllers[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * classString = self.viewControllers[indexPath.row];
//    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app.tabbar xmTabBarHidden:YES animated:YES];
    UIViewController * vc  = [NSClassFromString(classString) new];
    vc.title = classString;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate   = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
    }
    return _tableView;
}


- (NSMutableArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray array];
    }
    return _viewControllers;
}




@end
