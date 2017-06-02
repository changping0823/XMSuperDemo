//
//  XMCameraButton.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMCameraButton.h"

#define kXMCircleLineWidth 5.0f

@interface XMCameraButton ()
@property(nonatomic, assign)CGFloat progress;

@property(nonatomic, strong)UIView *mainView;

@property (nonatomic, strong) NSTimer *timer;

@property(nonatomic, assign)CGFloat value;


@end

@implementation XMCameraButton

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.mainView = [[UIView alloc]init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        self.mainView.layer.masksToBounds = YES;
        [self addSubview:self.mainView];
        
        
        
        UILongPressGestureRecognizer *longPress =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        //最短长按时间
        longPress.minimumPressDuration = 1;
        //允许移动最大距离
        longPress.allowableMovement = 1;
        //添加到指定视图
        [self.mainView addGestureRecognizer:longPress];
        
        
        //创建手势对象
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        //轻拍次数
        tap.numberOfTapsRequired =1;
        //轻拍手指个数
        tap.numberOfTouchesRequired =1;
        //讲手势添加到指定的视图上
        [self.mainView addGestureRecognizer:tap];

        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kXMCircleLineWidth, kXMCircleLineWidth, kXMCircleLineWidth, kXMCircleLineWidth));
        }];
        self.maxTime = 10.f;
        self.value = 1/self.maxTime;
    }
    return self;
}


-(void)tapAction:(UITapGestureRecognizer *)tap{
    if (self.takephotoBlock) {
        self.takephotoBlock();
    }
}

//长按事件
-(void)longPressAction:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [self addTimer];
        if (self.TakeVideoBlock) {
            self.TakeVideoBlock(XMCameraButtonStatus_start);
        }

    }else if (longPress.state == UIGestureRecognizerStateEnded){
        NSLog(@"长按结束");
        [self removeTimer];
        if (self.TakeVideoBlock) {
            self.TakeVideoBlock(XMCameraButtonStatus_end);
        }
    }
}

- (void)addTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)timerAction{
    self.progress += (self.value *0.1);
    if (self.progress >= 1) {
        [self removeTimer];
    }
}

- (void)removeTimer{
    [_timer invalidate];
    _timer = nil;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.mainView.layer.cornerRadius = (self.width -kXMCircleLineWidth *2) * 0.5;
}
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    NSLog(@"_progress == %f",_progress);
    if (_progress >= 1) {
        [self removeTimer];
    }
    [self setNeedsDisplay];
}
-(void)setMaxTime:(CGFloat)maxTime{
    _maxTime = maxTime;
    self.value = 1/_maxTime;
}


- (void)drawRect:(CGRect)rect{
    
    UIColor * circleColor = [UIColor greenColor];
    //路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    //线宽
    path.lineWidth = kXMCircleLineWidth;
    //颜色
    [circleColor set];
    //拐角
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    //半径
    CGFloat radius = (MIN(rect.size.width, rect.size.height) - kXMCircleLineWidth) * 0.5;
    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [path addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2 * _progress clockwise:YES];
    //连线
    [path stroke];
}



@end
