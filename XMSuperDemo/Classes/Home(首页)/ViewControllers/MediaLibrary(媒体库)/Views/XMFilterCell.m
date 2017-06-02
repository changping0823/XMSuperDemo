//
//  XMFilterCell.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/8.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMFilterCell.h"

@interface XMFilterCell ()
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UILabel *titleLabel;

@end

@implementation XMFilterCell

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.imageView = [[UIImageView alloc]init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.layer.masksToBounds = YES;
        [self addSubview:self.imageView];
        
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:14.f];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self);
            make.height.mas_equalTo(self.imageView.mas_width);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self);
            make.height.mas_equalTo(@20);
        }];
    }
    return self;
}

-(void)setFilter:(XMFilterModel *)filter{
    _filter = filter;
    self.titleLabel.text = _filter.name;
    self.imageView.image = _filter.thumbnailImage;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.layer.cornerRadius = self.imageView.width*0.5;
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}


@end
