//
//  XMTestView.m
//  XMSuperDemo
//
//  Created by 任长平 on 2016/12/5.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "XMTestView.h"

@implementation XMTestView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor RandomColor];
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"frame"]) {
        NSLog(@"self.moveView.y = %f", self.y);
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}


-(void)dealloc{
    NSLog(@"XMTestView --- dealloc");
}

@end
