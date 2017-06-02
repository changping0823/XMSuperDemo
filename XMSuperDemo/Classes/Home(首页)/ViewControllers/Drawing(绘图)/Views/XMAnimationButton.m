//
//  XMAnimationButton.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/16.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMAnimationButton.h"

@interface XMAnimationButton ()
@property(nonatomic, strong)UIActivityIndicatorView *activity;

@property(nonatomic, copy)NSString *titleText;

@end

@implementation XMAnimationButton
-(instancetype)initWithTitle:(NSString *)title backgroundColor:(UIColor *)color{
    if ([super init]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        self.backgroundColor = color;
        self.titleText = title;
    }
    return self;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        [self.activity startAnimating];
        [self setTitle:nil forState:UIControlStateNormal];
    }else{
        [self.activity stopAnimating];
        [self setTitle:self.titleText forState:UIControlStateNormal];
    }
}
-(void)setTitleText:(NSString *)titleText{
    _titleText = titleText;
    [self setTitle:_titleText forState:UIControlStateNormal];
}
-(void)layoutSubviews{
    [super layoutSubviews];
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}




-(UIActivityIndicatorView *)activity{
    if (!_activity) {
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activity.transform = CGAffineTransformMakeScale(0.8, 0.8) ;    // 改变transform 来改变活动控制器的大小。
        [self addSubview:activity];
        
        [activity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        _activity = activity;
    }
    return _activity;
}

@end
