//
//  UIFont+Extension.m
//  XMSuperDemo
//
//  Created by 任长平 on 2016/12/1.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "UIFont+Extension.h"
//#import <.h>


@implementation UIFont (Extension)


+ (instancetype)xm_FontOfSize:(CGFloat)fontSize{
    CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
    if (systemVersion >= 10.0){
        CGFloat p = fontSize * 17 / 17.5;
        fontSize = p;
    }
    return [UIFont systemFontOfSize:fontSize];
}
@end
