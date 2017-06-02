//
//  XMHTMLViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/15.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMHTMLViewController.h"
#import "XMWKWebViewController.h"

#define kLocalhost @"http://localhost:63342/jQuery%E6%89%8B%E6%9C%BA%E8%A7%A6%E5%B1%8F%E6%BB%91%E5%8A%A8%E5%88%87%E6%8D%A2%E9%80%89%E9%A1%B9%E5%8D%A1%E4%BB%A3%E7%A0%81/index.html?_ijt=9rvmsc2b5ol7tcr1290r33b8li"
//#define kLocalhost @"http://localhost:63342/HTML%E5%AD%A6%E4%B9%A0/HTML%E5%B8%B8%E8%A7%81%E6%A0%87%E7%AD%BE.html?"
//#define kLocalhost @"http://www.baidu.com"

@interface XMHTMLViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>
@property(nonatomic,strong)UISearchController *searchController;

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation XMHTMLViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick)];
    
    
    [self setSearchControllerView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    

//http://localhost:63342/HTML%E5%AD%A6%E4%B9%A0/HTML%E5%B8%B8%E8%A7%81%E6%A0%87%E7%AD%BE.html?_ijt=2r6brrooqieslcbmmo3idhvqn
}

//初始化SearchController初始化

- (void)setSearchControllerView{
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchBar.frame = CGRectMake(0, 0, 0, 44);
    self.searchController.dimsBackgroundDuringPresentation = false;
    //搜索栏表头视图
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.searchController.searchBar sizeToFit];
    //背景颜色
    self.searchController.searchBar.backgroundColor = [UIColor orangeColor];
    self.searchController.searchResultsUpdater = self;
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        _tableView = tableView;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}

-(void)rightBarButtonItemClick{
    XMWKWebViewController * wkWebView = [[XMWKWebViewController alloc]initWithUrlStr:kLocalhost];
    [self.navigationController pushViewController:wkWebView animated:YES];
}



@end




