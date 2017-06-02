//
//  XMFilterViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/8.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMFilterViewController.h"
#import "XMFilterCell.h"
#import "XMFilterTool.h"
#import "XMTools.h"



@interface XMFilterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic, strong)NSArray *filters;

@end

@implementation XMFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_backItem"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = self.image;
    [self.view addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 100, 0));
    }];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    // 设置最小行间距
    layout.minimumLineSpacing = 5;
    // 设置垂直间距
//    layout.minimumInteritemSpacing = 2;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView * collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerClass:[XMFilterCell class] forCellWithReuseIdentifier:@"XMFilterCell"];
    [self.view addSubview:collection];
    
    self.collectionView = collection;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    self.filters = [[XMFilterTool sharedInstance] getFilters:^(BOOL success) {
        [self.collectionView reloadData];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.filters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XMFilterCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XMFilterCell" forIndexPath:indexPath];
    cell.filter = self.filters[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return (CGSize){60,90};
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XMFilterModel * model = self.filters[indexPath.row];
    self.imageView.image = [[XMFilterTool sharedInstance] imageByFilteringImage:self.image filterType:model.type];
}

-(void)rightBarButtonItemClick{
    [[XMTools sharedXMTools] createAlbumInPhoneAlbum:self.imageView.image complete:^(BOOL success) {
        [self backBarButtonItemClick];
    }];
}
-(void)backBarButtonItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end













