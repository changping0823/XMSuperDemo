//
//  XMFilterView.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMFilterTool.h"

typedef void(^XMFilterViewBlock)(XMFilterModel * filter);

@interface XMFilterView : UIView

@property(nonatomic, copy)XMFilterViewBlock filterBlock;

@end
