//
//  XMFilterShowView.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMFilterShowView.h"
#import "XMPlayerView.h"

@interface XMFilterShowView ()<XMPlayerViewDelegate>
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)XMPlayerView *playerView;
@property(nonatomic, strong)UIButton *cancelButton;
@property(nonatomic, strong)UIButton *sureButton;

@property(nonatomic, strong)UIImage *photoImage;
@property(nonatomic, strong)NSURL *videoUrl;

@end

@implementation XMFilterShowView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.frame = [UIScreen mainScreen].bounds;
        
        
        self.cancelButton = [self buttonWithImage:@"icon_real_after_cancel~iphone" action:@selector(cancelButtonClick)];
        self.sureButton   = [self buttonWithImage:@"icon_real_after_confirm~iphone" action:@selector(sureButtonClick)];
        
        CGSize size = CGSizeMake(72, 72);
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
            make.left.mas_equalTo(self).offset(30);
            make.bottom.mas_equalTo(self).offset(-30);
        }];
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
            make.right.mas_equalTo(self).offset(-30);
            make.bottom.mas_equalTo(self).offset(-30);
        }];
        
        
        

    }
    return self;
}
-(UIButton *)buttonWithImage:(NSString *)image action:(SEL)action{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self addSubview:button];
    return button;
}


-(void)cancelButtonClick{
    [self dismiss];
}

-(void)sureButtonClick{
    if (self.photoImage) {
        
        [[XMTools sharedXMTools] createAlbumInPhoneAlbum:self.photoImage complete:^(BOOL success) {
            
        }];
    }else if (self.videoUrl){
        
        [[XMTools sharedXMTools]writeVideoAtPathToSavedPhotosAlbum:self.videoUrl complete:^(BOOL success) {
            
        }];
        
    }
    
    [self dismiss];
}

-(void)showImage:(UIImage *)image{
    self.photoImage = image;
    [self addSubview:self.imageView];
    [self sendSubviewToBack:self.imageView];

    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];

    self.imageView.image = image;
    [self show];
}

-(void)showVideo:(NSURL *)videoUrl{
    self.videoUrl = videoUrl;
    self.playerView = [[XMPlayerView alloc]initWithUrl:videoUrl delegate:self];
    [self addSubview:self.playerView];
    [self sendSubviewToBack:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self show];
}

-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)dismiss{
    [self removeFromSuperview];
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
-(XMPlayerView *)playerView{
    if (!_playerView) {
    }
    return _playerView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

@end
