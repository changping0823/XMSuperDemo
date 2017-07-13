//
//  XMDownMenu.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/6/29.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMDownMenu.h"


@interface XMDownMenuTitleLabel : UIView
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *arrowView;
@end

@interface XMDownMenu ()
@property(nonatomic, strong)UIButton *button;
@property(nonatomic, strong)UIView *backView;


@property(nonatomic, assign)NSInteger titleNumber;
@end

@implementation XMDownMenu

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor RandomColor];
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.backgroundColor = [UIColor RandomColor];
        [self addSubview:self.button];
        [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.backView = [[UIView alloc]init];
        self.backView.backgroundColor = [UIColor greenColor];
        self.backView.hidden = YES;
        [self addSubview:self.backView];
//        [self insertSubview:self.backView atIndex:0];
        
        NSLog(@"superview == %@",self.superview);
        

        
    }
    return self;
}



-(void)buttonClick:(UIButton *)sender{
    sender.selected = !sender.selected;
//    self.backView.height = SCREEN_HEIGHT - 108;
    self.backView.hidden = !sender.selected;
    
    NSLog(@"%@",NSStringFromCGRect(self.backView.frame));
    [self.superview bringSubviewToFront:self.backView];
    NSLog(@"%@",NSStringFromClass(self.superview.class));
    if ([self.delegate respondsToSelector:@selector(xm_downMenu:didSelectTitleAtTitleNumber:)]) {
        [self.delegate xm_downMenu:self didSelectTitleAtTitleNumber:0];
    }
}



-(void)reload{
    NSLog(@"titleNumber == %ld",(long)self.titleNumber);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.button.frame = CGRectMake(0, 0, 80, 44);
    self.backView.frame = CGRectMake(0, 44, self.width, SCREEN_HEIGHT - 108);

    
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}


@end








@implementation XMDownMenuTitleLabel

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        self.titleLabel = [[UILabel alloc]init];
        [self addSubview:self.titleLabel];
        
        self.arrowView = [[UIImageView alloc]init];
        [self addSubview:self.arrowView];
        
        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}


@end




