//
//  UILabel+Extension.m
//  XMSuperDemo
//
//  Created by 任长平 on 16/5/23.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

-(CGFloat)XMLabelHeight{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    CGSize maxSize = CGSizeMake(self.frame.size.width, MAXFLOAT);

    return [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
}
@end
