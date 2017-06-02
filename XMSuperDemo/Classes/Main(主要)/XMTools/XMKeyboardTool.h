//
//  XMKeyboardTool.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/4/25.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XMKeyboardToolBlock)(NSInteger index);

@interface XMKeyboardTool : UIToolbar

@property(nonatomic, copy)XMKeyboardToolBlock toolBlock;
@end
