//
//  XMButton.m
//  XMSuperDemo
//
//  Created by 任长平 on 16/8/3.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "XMButton.h"

// 获得按钮的大小
#define xm_btnWidth self.bounds.size.width
#define xm_btnHeight self.bounds.size.height
// 获得按钮中UILabel文本的大小
#define xm_labelWidth self.titleLabel.bounds.size.width
#define xm_labelHeight self.titleLabel.bounds.size.height
// 获得按钮中image图标的大小
#define xm_imageWidth self.imageView.bounds.size.width
#define xm_imageHeight self.imageView.bounds.size.height


@implementation XMButton

- (instancetype)initWithStyle:(BUTTON_STYLE)style{
    XMButton *xm_button = [[XMButton alloc] init];
    xm_button.buttonStyle = style;
    return xm_button;
}

-(void)setButtonStyle:(BUTTON_STYLE)buttonStyle{
    _buttonStyle = buttonStyle;
}
-(void)setSpace:(CGFloat)space{
    _space = space;
}
-(void)XMButtonImageLeft{
    CGRect titleFrame = self.titleLabel.frame;
    CGRect imageFrame = self.imageView.frame;
    
    imageFrame.origin.x = 0;
    titleFrame.origin.x = CGRectGetWidth(imageFrame) + _space;

    self.titleLabel.frame = titleFrame;
    self.imageView.frame = imageFrame;
    
}
-(void)XMButtonImageRight{
    
//    CGRect frame = [self titleFrame];
    CGRect imageFrame = self.imageView.frame;
    CGRect titleFrame = self.titleLabel.frame;

    titleFrame.origin.x = (xm_btnWidth -xm_labelWidth -xm_imageWidth -_space)*0.5;
    imageFrame.origin.x = titleFrame.origin.x + xm_labelWidth + _space;
    // 重写赋值frame
    self.titleLabel.frame = titleFrame;
    self.imageView.frame  = imageFrame;
}
-(void)XMButtonImageTop{
    
    CGRect frame = [self titleFrame];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    CGFloat imageX = (xm_btnWidth - xm_imageWidth) * 0.5;
    CGFloat imageY = (xm_btnHeight - xm_imageHeight - xm_labelHeight - _space)*0.5;
    
    self.imageView.frame = CGRectMake(imageX, imageY, xm_imageWidth, xm_imageHeight);
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, imageY +xm_imageHeight +_space, xm_btnWidth, xm_labelHeight);
    
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
}

-(void)XMButtonImageBottom{
    CGRect frame = [self titleFrame];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat imageX = (xm_btnWidth - xm_imageWidth) * 0.5;
    CGFloat titleX = (self.center.x - frame.size.width) * 0.5;
    CGFloat titleY = (xm_btnHeight -xm_labelHeight -xm_imageHeight -_space)*0.5;

    self.titleLabel.frame = CGRectMake(titleX, titleY, xm_btnWidth, xm_labelHeight);
    self.imageView.frame  = CGRectMake(imageX, titleY +_space +xm_labelHeight, xm_imageWidth, xm_imageHeight);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
}

#pragma mark - 计算文本的的宽度
-(CGRect)titleFrame{
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    
    return [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:dictM
                                              context:nil];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    switch (self.buttonStyle) {
        case BUTTON_STYLE_LEFT:
            [self XMButtonImageLeft];
            break;
        case BUTTON_STYLE_RIGHT:
            [self XMButtonImageRight];
            break;
        case BUTTON_STYLE_TOP:
            [self XMButtonImageTop];
            break;
        case BUTTON_STYLE_BOTTOM:
            [self XMButtonImageBottom];
            break;
            
        default:
            break;
    }
    
}




@end
