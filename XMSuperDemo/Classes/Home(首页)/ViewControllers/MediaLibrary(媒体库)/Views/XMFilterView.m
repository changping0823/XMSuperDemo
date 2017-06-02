//
//  XMFilterView.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMFilterView.h"
#import "XMFilterCell.h"

@interface XMFilterView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)NSArray *filters;
@end

@implementation XMFilterView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        // 设置最小行间距
        layout.minimumLineSpacing = 15;
        // 设置垂直间距
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView * collection = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        collection.delegate = self;
        collection.dataSource = self;
        collection.backgroundColor = [UIColor clearColor];
        [collection registerClass:[XMFilterCell class] forCellWithReuseIdentifier:@"XMFilterCell"];
        [self addSubview:collection];
        
        self.collectionView = collection;
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@100);
            make.left.top.right.mas_equalTo(self);
        }];
        
        self.filters = [[XMFilterTool sharedInstance] getFilters:^(BOOL success) {
            [self.collectionView reloadData];
        }];
        

    }
    return self;
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
    return (CGSize){60,80};
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.filterBlock) {
        self.filterBlock(self.filters[indexPath.row]);
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}


@end
