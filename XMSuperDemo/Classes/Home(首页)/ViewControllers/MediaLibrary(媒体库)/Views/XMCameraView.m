//
//  XMCameraView.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMCameraView.h"
#import "XMButton.h"

#define kBottomViewH 150

@interface XMCameraView ()
@property(nonatomic, strong)UIView *topView;
@property(nonatomic, strong)UIButton *cancelButton;
@property(nonatomic, strong)UIButton *rotateButton;

@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)XMCameraButton *cameraButton;
@property(nonatomic, strong)XMButton *filterButton;

@property(nonatomic, strong)XMFilterView *filterView;

@end

@implementation XMCameraView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        
        [self createTopView];

        [self createBottomView];
        

    }
    return self;
}

-(void)createTopView{
    self.topView = [[UIView alloc]init];
    [self addSubview:self.topView];

    self.cancelButton = [self buttonWithImage:@"camera_cancel" title:nil action:@selector(cancelButtonClick)];
    [self.topView addSubview:self.cancelButton];
    
    self.rotateButton = [self buttonWithImage:@"icon_real_rotate_white" title:nil action:@selector(rotateButtonClick:)];
    [self.topView addSubview:self.rotateButton];

    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(@80);
    }];
    
    CGSize size = CGSizeMake(45, 45);
    [self.rotateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
        make.centerY.mas_equalTo(self.topView);
        make.right.mas_equalTo(self.topView).offset(-20);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.centerY.mas_equalTo(self.topView);
        make.size.mas_equalTo(size);
    }];

    
}

-(void)createBottomView{
    self.bottomView = [[UIView alloc]init];
    [self addSubview:self.bottomView];
    [self bringSubviewToFront:self.bottomView];
    
    __weak typeof(self) weakSelf = self;
    self.cameraButton = [[XMCameraButton alloc]init];
    self.cameraButton.takephotoBlock = ^{
        if ([weakSelf.delegate respondsToSelector:@selector(xm_cameraViewTakephotos:)]) {
            [weakSelf.delegate xm_cameraViewTakephotos:weakSelf];
        }
    };
    self.cameraButton.TakeVideoBlock = ^(XMCameraButtonStatus status) {
        if ([weakSelf.delegate respondsToSelector:@selector(xm_cameraViewTakeVideo:stauts:)]) {
            [weakSelf.delegate xm_cameraViewTakeVideo:weakSelf stauts:status];
        }
    };
    self.filterButton = [[XMButton alloc]initWithStyle:BUTTON_STYLE_TOP];
    [self.filterButton setImage:[UIImage imageNamed:@"icon_real_after_filter_white"] forState:UIControlStateNormal];
    [self.filterButton setTitle:@"滤镜" forState:UIControlStateNormal];
    self.filterButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [self.filterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.filterButton addTarget:self action:@selector(filterButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.filterButton];
    
    [self.bottomView addSubview:self.cameraButton];
    
}

-(UIButton *)buttonWithImage:(NSString *)image title:(NSString *)title action:(SEL)action{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


-(void)cancelButtonClick{
    if ([self.delegate respondsToSelector:@selector(xm_cameraViewCancel:)]) {
        [self.delegate xm_cameraViewCancel:self];
    }
}
-(void)rotateButtonClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(xm_cameraView:rotateCamera:)]) {
        [self.delegate xm_cameraView:self rotateCamera:sender.selected];
    }
}


-(void)filterButtonClick{
    [UIView animateWithDuration:0.5 animations:^{
        self.filterView.y = self.height - 160;
        self.bottomView.y = self.height - 80;
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.5 animations:^{
        self.filterView.y = self.height;
        self.bottomView.y = self.height - kBottomViewH;
    } completion:^(BOOL finished) {
        
    }];
}

-(XMFilterView *)filterView{
    if (!_filterView) {
        _filterView = [[XMFilterView alloc]initWithFrame:CGRectMake(0, self.height, self.width, 160)];
        [self insertSubview:_filterView belowSubview:self.bottomView];
        __weak typeof(self) weakSelf = self;
        _filterView.filterBlock = ^(XMFilterModel *filter) {
            if ([weakSelf.delegate respondsToSelector:@selector(xm_cameraView:selectFilter:)]) {
                [weakSelf.delegate xm_cameraView:weakSelf selectFilter:filter];
            }
        };
        [self addSubview:_filterView];
    }
    return _filterView;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.bottomView.size = CGSizeMake(self.width, kBottomViewH);
    self.bottomView.centerX = self.centerX;

    
    self.cameraButton.size = CGSizeMake(80, 80);
    self.cameraButton.centerX = self.bottomView.centerX;
    self.cameraButton.y = 0;

    self.filterButton.size = CGSizeMake(60, 80);
    self.filterButton.centerY = self.cameraButton.centerY;
    self.filterButton.x = CGRectGetMaxX(self.cameraButton.frame) + 20;
    [self bringSubviewToFront:self.bottomView];
    
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.bottomView.y = self.height - kBottomViewH;
}

@end
