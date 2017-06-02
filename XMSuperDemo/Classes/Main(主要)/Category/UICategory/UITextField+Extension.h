//
//  UITextField+Extension.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/4/25.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMKeyboardTool.h"

@interface UITextField (Extension)

@property(nonatomic, assign)BOOL showKeyboardTool;
@property(nonatomic, strong)XMKeyboardTool *keyboardTool;

@end
