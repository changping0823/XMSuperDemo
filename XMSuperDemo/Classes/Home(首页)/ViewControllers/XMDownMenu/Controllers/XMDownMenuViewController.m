//
//  XMDownMenuViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/6/29.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMDownMenuViewController.h"
#import "XMDownMenu.h"

@interface XMDownMenuViewController ()<UITableViewDelegate,UITableViewDataSource,XMDownMenuDelegate,XMDownMenuDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIView *sectionView;

@property(nonatomic, strong)XMDownMenu *toolBar;

@property(nonatomic, strong)NSMutableArray *areaArray;
@property(nonatomic, strong)NSArray *categoryArray;
@property(nonatomic, strong)NSArray *intelligentSortArray;
@property(nonatomic, strong)NSArray *nearbyList;

@property(nonatomic, assign)NSInteger sectionNumber;

@end

@implementation XMDownMenuViewController

-(NSArray *)plistArray:(NSString *)plistName{
    NSString *areaPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    return [[NSArray alloc] initWithContentsOfFile:areaPath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.ba
    self.view.backgroundColor = [UIColor whiteColor];
    self.sectionNumber = 8;
    
    self.areaArray = [NSMutableArray arrayWithArray:[self plistArray:@"areaList"]];
    [self.areaArray insertObject:@{@"districtId":@(0),@"districtName":@"附近",@"parentId":@(0)} atIndex:0];
    
    self.categoryArray = [self plistArray:@"categoryList"];
    self.intelligentSortArray = [self plistArray:@"intelligentSort"];
    self.nearbyList = [self plistArray:@"nearbyList"];

    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    [self.view bringSubviewToFront:self.toolBar];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    [self.sectionView addSubview:self.toolBar];
    return self.sectionView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.sectionNumber;
    }
    return 30;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"section = %ld   row == %ld",(long)indexPath.section,(long)indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    

    CGFloat offsetY =  scrollView.contentOffset.y;
    if (offsetY >= self.sectionNumber * 44) {
        self.toolBar.y = 64;
        [self.view addSubview:self.toolBar];
    }else{
        self.toolBar.y = 0;
        [self.sectionView addSubview:self.toolBar];
    }

}



-(void)hiddenDownMenu:(XMDownMenu *)menu{
    
}
-(void)xm_downMenu:(XMDownMenu *)menu didSelectTitleAtTitleNumber:(NSInteger)number{
    NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:1];
    
    [self.tableView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
-(NSInteger)titltNumberOfDownMenu:(XMDownMenu *)menu{
    return 4;
}


- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
//        tableView.tableHeaderView = self.seactionView;
//        tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
//        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
        _tableView = tableView;
    }
    return _tableView;
}
-(UIView *)sectionView{
    if (!_sectionView) {
        _sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    }
    return _sectionView;
}
-(XMDownMenu *)toolBar{
    if (!_toolBar) {
        _toolBar = [[XMDownMenu alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,44)];
        _toolBar.delegate = self;
        _toolBar.dataSource = self;
    }
    return _toolBar;
}

@end
