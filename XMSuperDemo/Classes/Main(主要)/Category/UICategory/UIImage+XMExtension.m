//
//  UIImage+XMExtension.m
//  XMSuperDemo
//
//  Created by 任长平 on 2016/11/18.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "UIImage+XMExtension.h"

@implementation UIImage (XMExtension)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
