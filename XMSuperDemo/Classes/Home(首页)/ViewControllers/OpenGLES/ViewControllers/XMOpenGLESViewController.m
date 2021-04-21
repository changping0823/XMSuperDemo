//
//  XMOpenGLESViewController.m
//  XMSuperDemo
//
//  Created by Charles on 2021/4/20.
//  Copyright © 2021 任长平. All rights reserved.
//

#import "XMOpenGLESViewController.h"
#import "XMOpenGLESView.h"

@interface XMOpenGLESViewController ()
@property (nonatomic, strong) XMOpenGLESView *contentView;
@end

@implementation XMOpenGLESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupConfig];
}
- (void)setupConfig{
    self.contentView = [[XMOpenGLESView alloc] init];
    [self.view addSubview:self.contentView];
    
//    self.contentView.springDelegate = self;
    [self.contentView updateImage:[UIImage imageNamed:@"dilireba.jpeg"]];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(100, 20, 60, 20));
    }];
}



@end
