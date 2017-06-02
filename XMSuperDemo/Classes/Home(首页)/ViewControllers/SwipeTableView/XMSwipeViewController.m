//
//  XMSwipeViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2016/11/29.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "XMSwipeViewController.h"
#import "SwipeTableView.h"
#import "XMSwipeTestViewController.h"

@interface XMSwipeViewController ()<SwipeTableViewDataSource,SwipeTableViewDelegate>
@property (nonatomic, strong) SwipeTableView * swipeTableView;

@end

@implementation XMSwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.swipeTableView = [[SwipeTableView alloc]initWithFrame:self.view.bounds];
    _swipeTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _swipeTableView.delegate = self;
    _swipeTableView.dataSource = self;
    _swipeTableView.shouldAdjustContentSize = YES;
//    _swipeTableView.swipeHeaderView = disableBarScroll?nil:self.tableViewHeader;
//    _swipeTableView.swipeHeaderBar = self.segmentBar;
    _swipeTableView.swipeHeaderBarScrollDisabled = YES;
    _swipeTableView.swipeHeaderTopInset = 0;
    [self.view addSubview:_swipeTableView];

}

#pragma mark - SwipeTableView M

//- (NSInteger)numberOfItemsInSwipeTableView:(SwipeTableView *)swipeView {
//    return 4;
//}
//- (UIScrollView *)swipeTableView:(SwipeTableView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIScrollView *)view {
//    
//}




@end
