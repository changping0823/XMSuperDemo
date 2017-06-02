//
//  XMWaveView.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/3.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMWaveView : UIView
@property(nonatomic, strong)UIColor *upWaveColor;
@property(nonatomic, strong)UIColor *downWaveColor;
@property(nonatomic, strong)UIColor *backColor;

@property(nonatomic, assign)float progress;
@end
