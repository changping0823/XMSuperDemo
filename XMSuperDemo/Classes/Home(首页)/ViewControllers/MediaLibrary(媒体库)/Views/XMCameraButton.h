//
//  XMCameraButton.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XMCameraButtonStatus) {
    XMCameraButtonStatus_start = 0,
    XMCameraButtonStatus_end = 1,
};

typedef void(^Takephotos)();
typedef void(^TakeVideo)(XMCameraButtonStatus status);

@interface XMCameraButton : UIView

/** 最大的录制时间，默认为10 */
@property (nonatomic, assign) CGFloat maxTime;

@property(nonatomic, copy)Takephotos takephotoBlock;
@property(nonatomic, copy)TakeVideo TakeVideoBlock;

@end
