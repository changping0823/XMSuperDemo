//
//  XMFireView.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/4.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMFireView.h"

@interface XMFireView ()
@property(nonatomic, strong)CAEmitterLayer *fireLayer;

@end


@implementation XMFireView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
         self.fireLayer = [CAEmitterLayer layer];

        // 发射源尺寸大小
        self.fireLayer.emitterSize = CGSizeMake(100, 100);
        // 发射模式
        self.fireLayer.emitterMode = kCAEmitterLayerOutline;
        // 发射源的形状
        self.fireLayer.emitterShape = kCAEmitterLayerLine;
        // 发射源的渲染模式
        self.fireLayer.renderMode = kCAEmitterLayerAdditive;
        // 发射源初始化随机数产生的种子
        self.fireLayer.seed = (arc4random()%100)+1;
        
        
        
        /**
         * 添加发射点
         一个圆（发射点）从底下发射到上面的一个过程
         */
        CAEmitterCell* rocket = [CAEmitterCell emitterCell];
        rocket.birthRate = 1.0; //是每秒某个点产生的effectCell数量
        rocket.emissionRange = 0.25 * M_PI; // 周围发射角度
        rocket.velocity = 400; // 速度
        rocket.velocityRange = 200; // 速度范围
        rocket.yAcceleration = 95; // 粒子y方向的加速度分量
        rocket.lifetime = 1.52; // effectCell的生命周期，既在屏幕上的显示时间要多长。
        
        // 下面是对 rocket 中的内容，颜色，大小的设置
        rocket.contents = (id) [[UIImage imageNamed:@"avatar_grassroot"] CGImage];
        rocket.scale = 0.2;
        rocket.color = [[UIColor RandomColor] CGColor];
        rocket.greenRange = 1.0;
        rocket.redRange = 1.0;
        rocket.blueRange = 1.0;
        rocket.spinRange = M_PI; // 子旋转角度范围
        
        /**
         * 添加爆炸的效果，突然之间变大一下的感觉
         */
        CAEmitterCell* burst = [CAEmitterCell emitterCell];
        burst.birthRate = 1.0;
        burst.velocity = 0;
        burst.scale = 2.5;
        burst.redSpeed =-1.5;
        burst.blueSpeed =+1.5;
        burst.greenSpeed =+1.0;
        burst.lifetime = 0.35;
        
        /**
         * 添加星星扩散的粒子
         */
        CAEmitterCell* spark = [CAEmitterCell emitterCell];
        spark.birthRate = 400;
        spark.velocity = 125;
        spark.emissionRange = 2* M_PI;
        spark.yAcceleration = 75; //粒子y方向的加速度分量
        spark.lifetime = 3;
        
        spark.contents = (id) [[UIImage imageNamed:@"common_icon_membership"] CGImage];
        spark.scaleSpeed =-0.2;
        spark.greenSpeed =-0.1;
        spark.redSpeed = 0.4;
        spark.blueSpeed =-0.1;
        spark.alphaSpeed =-0.25; // 例子透明度的改变速度
        spark.spin = 2* M_PI; // 子旋转角度
        spark.spinRange = 2* M_PI;
        
        // 将 CAEmitterLayer 和 CAEmitterCell 结合起来
        self.fireLayer.emitterCells = [NSArray arrayWithObject:rocket];
        //在圈圈粒子的基础上添加爆炸粒子
        rocket.emitterCells = [NSArray arrayWithObject:burst];
        //在爆炸粒子的基础上添加星星粒子
        burst.emitterCells = [NSArray arrayWithObject:spark];
        // 添加到图层上
        [self.layer addSublayer:self.fireLayer];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 发射源的位置
    self.fireLayer.emitterPosition = CGPointMake(self.width/2, self.height - 50);
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}




@end







