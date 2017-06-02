//
//  XMDrawingView.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/4/26.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMDrawingView.h"
#import <CoreText/CoreText.h>

#define BackGroundColor [UIColor colorWithRed:96/255.0f green:159/255.0f blue:150/255.0f alpha:1]
#define WaveColor1 [UIColor colorWithRed:136/255.0f green:199/255.0f blue:190/255.0f alpha:1]
#define WaveColor2 [UIColor colorWithRed:28/255.0 green:203/255.0 blue:174/255.0 alpha:1]

@interface XMDrawingView ()

@property (nonatomic, strong) UIBezierPath *path;


@property(nonatomic, strong)CAShapeLayer *waveLayer1;
@property(nonatomic, strong)CAShapeLayer *waveLayer2;
@property(nonatomic, strong)CAShapeLayer *textLayer;
@property(nonatomic, strong)CADisplayLink *disPlayLink;

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
@implementation XMDrawingView

-(instancetype)init{
    if ([super init]) {
        self.backgroundColor = [UIColor whiteColor];
//        [self drawInText:@"你在红楼，我在西游"];

    }
    return self;
}


-(void)wave{
    self.waveLayer1 = [CAShapeLayer layer];
    self.waveLayer1.fillColor = WaveColor1.CGColor;
    self.waveLayer1.strokeColor = WaveColor1.CGColor;
    
    [self.layer addSublayer:self.waveLayer1];
    
    self.waveLayer2 = [CAShapeLayer layer];
    self.waveLayer2.fillColor = WaveColor2.CGColor;
    self.waveLayer2.strokeColor = WaveColor2.CGColor;
    [self.layer addSublayer:self.waveLayer2];
    
    
    
    
    self.path = [UIBezierPath bezierPath];
    [self.path moveToPoint:CGPointZero];
    UIColor * color = [UIColor colorWithRed:0.5 green:0.5 blue:0.9 alpha:1.0];

    self.textLayer = [CAShapeLayer layer];
    self.textLayer.fillColor = color.CGColor;
    self.textLayer.strokeColor = color.CGColor;
    [self.layer addSublayer:self.textLayer];
    
    
    self.layer.cornerRadius = self.bounds.size.width/2.0f;
    self.layer.masksToBounds = true;
    self.backgroundColor = BackGroundColor;
    
}
//初始化数据

-(void)buildData
{
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
//更新偏距的大小 直到达到目标偏距 让wave有一个匀速增长的效果
-(void)updateWaveY
{
    CGFloat targetY = self.bounds.size.height - self.progress * self.bounds.size.height;
    if (self.waveY < targetY) {
        self.waveY += 2;
    }
    if (self.waveY > targetY ) {
        self.waveY -= 2;
    }
}

//更新第一层曲线
-(void)updateWave1
{
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
        y = self.waveAmplitude * cos(self.wavePalstance * x + self.waveX) + self.waveY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    //填充底部颜色
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    self.waveLayer1.path = path;
    CGPathRelease(path);
}

//更新第二层曲线
-(void)updateWave2
{
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
        y = self.waveAmplitude * sin(self.wavePalstance * x + self.waveX) + self.waveY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    //添加终点路径、填充底部颜色
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    self.waveLayer2.path = path;
    CGPathRelease(path);
    
}

//停止动画
-(void)stop
{
    if (self.disPlayLink) {
        [self.disPlayLink invalidate];
        self.disPlayLink = nil;
    }
}
//回收内存
-(void)dealloc
{
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

-(void)setTextValue{
    

}
-(void)setProgress:(float)progress{
    _progress = progress;
    [self setTextValue];
    [self setNeedsDisplay];
}

- (void)drawRect: (CGRect) rect {
    
    UIColor * color = [UIColor colorWithRed:0.5 green:0.5 blue:0.9 alpha:1.0];

    
    NSString * text = [NSString stringWithFormat:@"%.0f%%",self.progress*100];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    dict[NSForegroundColorAttributeName] = color;
    [text drawInRect:CGRectMake(self.centerX, self.centerY, 100, 100) withAttributes:dict];
    
}
-(void)drawInText:(NSString *)text{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    [text drawInRect:CGRectMake(120, 350, 200, 40) withAttributes:dict];
}

- (void)drawInContext:(CGContextRef)ctx{
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self wave];
    [self buildData];
}



@end





