//
//  XMAnimationText.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/4.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMAnimationText : CALayer
+(void)createAnimationLayerWithString:(NSString*)string
                              andRect:(CGRect)rect
                              andView:(UIView *)view
                              andFont:(UIFont*)ui_font
                       andStrokeColor:(UIColor*)color;
@end
