//
//  XMDiscoverViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2016/11/18.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "XMDiscoverViewController.h"
#import "XMWebViewController.h"
#import "XMTestView.h"

@interface XMDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)NSMutableArray *array;

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)XMTestView *sectionView;

@end

@implementation XMDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [NSMutableArray arrayWithObjects:@(0),@(1),@(2),@(3),@(4),@(5),@(6), nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    
    self.view.backgroundColor = [UIColor RandomColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

}

-(void)rightBarButtonItemClick{
    [self.array addObject:@(self.array.count)];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.array.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)leftBarButtonItemClick{
    
    if (self.array.count == 0) return;
    
    
    [self.array removeLastObject];

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.array.count inSection:0];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    
    if (self.array.count == 0) return;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:self.array.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
}

-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [view addSubview:self.sectionView];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 25;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(XMTestView *)sectionView{
    if(!_sectionView){
        _sectionView = [[XMTestView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    }
    return _sectionView;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    @"http://t.cn/RMwY8qY"
    XMTestViewController *webVC = [[XMTestViewController alloc]initWithUrl:[NSURL URLWithString:@"http://www.baidu.com"]];
//    XMTestViewController *webVC = [[XMTestViewController alloc]initWithUrl:[NSURL URLWithString:@"http://t.cn/RMwY8qY"]];
//    webVC.progressClolor = [UIColor redColor];
    
    [self.navigationController pushViewController:webVC animated:YES];
    
    
}


@end
