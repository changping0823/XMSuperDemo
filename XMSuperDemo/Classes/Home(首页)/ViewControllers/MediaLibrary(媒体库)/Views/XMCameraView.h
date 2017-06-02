//
//  XMCameraView.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMFilterView.h"      //存放滤镜的view
#import "XMCameraButton.h"

@class XMCameraView;

@protocol XMCameraDelegate <NSObject>
-(void)xm_cameraViewCancel:(XMCameraView *)view;
-(void)xm_cameraView:(XMCameraView *)view rotateCamera:(BOOL)rotate;
-(void)xm_cameraViewTakephotos:(XMCameraView *)view;
-(void)xm_cameraViewTakeVideo:(XMCameraView *)view stauts:(XMCameraButtonStatus)status;
-(void)xm_cameraView:(XMCameraView *)view selectFilter:(XMFilterModel *)filter;

@end

@interface XMCameraView : UIView

@property(nonatomic, weak)id<XMCameraDelegate> delegate;

@end
