//
//  XMWaveView.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/3.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMWaveView.h"


@interface XMWaveView ()

@property(nonatomic, strong)CAShapeLayer *waveLayer1;
@property(nonatomic, strong)CAShapeLayer *waveLayer2;
@property(nonatomic, strong)UIBezierPath *path;
@property(nonatomic, strong)CADisplayLink *disPlayLink;
@property(nonatomic, strong)UILabel *progressLabel;

/**
 曲线的振幅
 */
@property(nonatomic, assign)CGFloat waveAmplitude;
/**
 曲线角速度
 */

@property(nonatomic, assign)CGFloat wavePalstance;
/**
 曲线初相
 */

@property(nonatomic, assign)CGFloat waveX;
/**
 曲线偏距
 */

@property(nonatomic, assign)CGFloat waveY;

/**
 曲线移动速度
 */
@property(nonatomic, assign)CGFloat waveMoveSpeed;

@end

@implementation XMWaveView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.path = [UIBezierPath bezierPath];
        [self.path moveToPoint:CGPointZero];
//        UIColor * color = [UIColor colorWithRed:0.5 green:0.5 blue:0.9 alpha:1.0];
        
        self.layer.masksToBounds = true;
        
        /** 设置默认颜色 */
        self.upWaveColor = [UIColor colorWithRed:136/255.0f green:199/255.0f blue:190/255.0f alpha:1];
        self.downWaveColor = [UIColor colorWithRed:28/255.0 green:203/255.0 blue:174/255.0 alpha:1];
        self.backColor = [UIColor colorWithRed:96/255.0f green:159/255.0f blue:150/255.0f alpha:1];
        
//        [self addSubview:self.progressLabel];
        
    }
    return self;
}

//初始化数据
-(void)buildData{
    
    
    self.progress = 0.4;
    //振幅
    self.waveAmplitude = 10;
    //角速度
    self.wavePalstance = M_PI/self.bounds.size.width;
    //偏距
    self.waveY = 0;
    //初相
    self.waveX = 0;
    //x轴移动速度
    self.waveMoveSpeed = self.wavePalstance * 10;
    
    //以屏幕刷新速度为周期刷新曲线的位置
    self.disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
    [self.disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
-(void)updateWave:(CADisplayLink *)link{
    //更新X
    self.waveX += self.waveMoveSpeed;
    [self updateWaveY];
    [self updateWave1];
    [self updateWave2];
}

-(void)updateWaveY{
    CGFloat targetY = self.bounds.size.height - self.progress * self.bounds.size.height;
    if (self.waveY < targetY) {
        self.waveY += 2;
    }
    if (self.waveY > targetY ) {
        self.waveY -= 2;
    }
}
-(void)updateWave1{
    CGMutablePathRef path = [self layerPath:1];
    self.waveLayer1.path = path;
    CGPathRelease(path);
}
-(void)updateWave2{
    CGMutablePathRef path = [self layerPath:0];
    self.waveLayer2.path = path;
    CGPathRelease(path);
}

-(CGMutablePathRef)layerPath:(NSInteger)type{
    //波浪宽度
    CGFloat waterWaveWidth = self.bounds.size.width;
    //初始化运动路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, self.waveY);
    //初始化波浪其实Y为偏距
    CGFloat y = self.waveY;
    //正弦曲线公式为： y=Asin(ωx+φ)+k;
    for (float x = 0.0f; x <= waterWaveWidth ; x++) {
        if (type == 0) {
            y = self.waveAmplitude * sin(self.wavePalstance * x + self.waveX) + self.waveY;
        }else if (type == 1){
            y = self.waveAmplitude * cos(self.wavePalstance * x + self.waveX) + self.waveY;
        }
        CGPathAddLineToPoint(path, nil, x, y);
    }
    //添加终点路径、填充底部颜色
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    return path;
}
-(void)setUpWaveColor:(UIColor *)upWaveColor{
    _upWaveColor = upWaveColor;
}
-(void)setDownWaveColor:(UIColor *)downWaveColor{
    _downWaveColor = downWaveColor;
}
-(void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    self.backgroundColor = _backColor;
}
-(void)setProgress:(float)progress{
    _progress = progress;
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",_progress * 100];
}


//停止动画
-(void)stop{
    if (self.disPlayLink) {
        [self.disPlayLink invalidate];
        self.disPlayLink = nil;
    }
}
//回收内存
-(void)dealloc{
    [self stop];
    if (self.waveLayer1) {
        [self.waveLayer1 removeFromSuperlayer];
        self.waveLayer1 = nil;
    }
    if (self.waveLayer2) {
        [self.waveLayer2 removeFromSuperlayer];
        self.waveLayer2 = nil;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.waveLayer1 = [self shapeLayer:self.upWaveColor];
    self.waveLayer2 = [self shapeLayer:self.downWaveColor];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor redColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:layer];
    
    [self buildData];
    
    /** 画圆 */
    self.layer.cornerRadius = self.bounds.size.width/2.0f;
    
    [self addSubview:self.progressLabel];

    self.progressLabel.frame = self.bounds;

}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(CAShapeLayer *)shapeLayer:(UIColor *)color{
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.fillColor = color.CGColor;
    layer.strokeColor = color.CGColor;
    [self.layer addSublayer:layer];
    return layer;
}

-(UILabel *)progressLabel{
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc]init];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.font=[UIFont systemFontOfSize:20];
        _progressLabel.textColor = [UIColor whiteColor];
    }
    return _progressLabel;
}




@end
