//
//  UITextField+Extension.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/4/25.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "UITextField+Extension.h"
#import <objc/runtime.h>

static NSString *ShowKeyboardToolKey = @"ShowKeyboardToolKey";
static NSString *KeyboardToolKey     = @"KeyboardToolKey";

@interface UITextField ()

@end

@implementation UITextField (Extension)


-(void)setShowKeyboardTool:(BOOL)show{
    objc_setAssociatedObject(self, &ShowKeyboardToolKey, @(show), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)showKeyboardTool{
    return objc_getAssociatedObject(self, &ShowKeyboardToolKey);
}


-(void)setKeyboardTool:(XMKeyboardTool *)keyboardTool{
    objc_setAssociatedObject(self, &KeyboardToolKey, keyboardTool, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
-(XMKeyboardTool *)keyboardTool{
    return objc_getAssociatedObject(self, &KeyboardToolKey);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (!self.keyboardTool && self.showKeyboardTool) {
        self.keyboardTool = [[XMKeyboardTool alloc]init];
        self.keyboardTool.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
        self.keyboardTool.frame = CGRectMake(0, 0, 400, 30);
        __weak typeof(self) weak = self;
        self.keyboardTool.toolBlock = ^(NSInteger index) {
            if (index == 0) {
                
            }
            [weak resignFirstResponder];
        };
        self.inputAccessoryView = self.keyboardTool;

    }
}
@end







