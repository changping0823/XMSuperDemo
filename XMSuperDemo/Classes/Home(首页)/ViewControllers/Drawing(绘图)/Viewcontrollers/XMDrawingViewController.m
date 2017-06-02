//
//  XMDrawingViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/4/26.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMDrawingViewController.h"
#import "XMDrawingView.h"
#import "XMWaveView.h"
#import "XMFireView.h"
#import "XMAnimationText.h"
#import "XMAnimationButton.h"


@interface XMDrawingViewController ()
@property(nonatomic, strong)XMWaveView *waveView;
@property(nonatomic, strong)XMFireView *fireView;
@property(nonatomic, strong)UISlider * slider;
@property(nonatomic, strong)XMAnimationButton *button;
@end

@implementation XMDrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /** 波浪 */
    [self wave];
    /** 烟花 */
//    [self fire];
    /** 文字动画 */
//    [self animationText];
    
    self.button = [[XMAnimationButton alloc]initWithTitle:@"登录" backgroundColor:[UIColor RandomColor]];
    [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 44));
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-100);
    }];
}

-(void)buttonClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

#pragma mark - 文字动画
-(void)animationText{
    
    for (id layer in self.view.layer.sublayers) {
        if([layer isKindOfClass:[XMAnimationText class]])
        {
            [layer removeFromSuperlayer];
        }
    }
    
    CGRect rect = CGRectMake(20.0f, -100.0f, CGRectGetWidth(self.view.layer.bounds) - 40.0f,CGRectGetHeight(self.view.layer.bounds) - 84.0f);
    [XMAnimationText createAnimationLayerWithString:@"苹果官方给出这两个属性"
                                            andRect:rect
                                            andView:self.view
                                            andFont:[UIFont boldSystemFontOfSize:40]
                                     andStrokeColor:[UIColor RandomColor]];
}
#pragma mark - 烟花🎆🎆🎆🎆
-(void)fire{
    
    self.view.backgroundColor = [UIColor blackColor];
    self.fireView = [[XMFireView alloc]init];
    self.fireView.frame = self.view.bounds;
    [self.view addSubview:self.fireView];

}

#pragma mark - 波浪🌊🌊🌊🌊
-(void)wave{
    self.waveView = [[XMWaveView alloc]init];
    self.waveView.x = (self.view.width -200)/2;
    self.waveView.y = 100;
    self.waveView.size = CGSizeMake(200, 200);
    [self.view addSubview:self.waveView];
    self.slider.value = self.waveView.progress = 0.4;
}

-(UISlider *)slider{
    if (!_slider) {
        UISlider * slider = [[UISlider alloc]init];
        slider.frame = CGRectMake(50, self.view.height - 40, 275, 10);
        slider.maximumValue = 1.0;
        slider.minimumValue = 0.f;
        [slider addTarget:self action:@selector(changeProgress:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:slider];
        _slider = slider;
    }
    return _slider;
}



- (void)changeProgress:(UISlider *)slider {
    self.waveView.progress = slider.value;
}


@end
