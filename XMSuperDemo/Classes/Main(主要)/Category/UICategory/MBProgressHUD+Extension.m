//
//  MBProgressHUD+Extension.m
//  XMSuperDemo
//
//  Created by 任长平 on 2016/11/16.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

NSString * const XMMBProgressHUDMsgLoading = @"正在加载...";
NSString * const XMMBProgressHUDMsgLoadError = @"加载失败";
NSString * const XMMBProgressHUDMsgLoadSuccessful = @"加载成功";
NSString * const XMMBProgressHUDMsgNoMoreData = @"没有更多数据了";
NSTimeInterval   XMMBProgressHUDHideTimeInterval = 1.2f;

static CGFloat FONT_SIZE = 14.0f;
static CGFloat OPACITY = 0.85;

@implementation MBProgressHUD (Extension)


+ (MBProgressHUD *)xm_showHUDAddedTo:(UIView *)view title:(NSString *)title animated:(BOOL)animated {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:animated];
    HUD.labelFont = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.labelText = title;
    HUD.opacity = OPACITY;
    return HUD;
}

+ (MBProgressHUD *)xm_showHUDAddedTo:(UIView *)view title:(NSString *)title {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.labelFont = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.labelText = title;
    HUD.opacity = OPACITY;
    return HUD;
}

- (void)xm_hideWithTitle:(NSString *)title hideAfter:(NSTimeInterval)afterSecond {
    if (title) {
        self.labelText = title;
        self.mode = MBProgressHUDModeText;
    }
    [self hide:YES afterDelay:afterSecond];
}

- (void)xm_hideAfter:(NSTimeInterval)afterSecond {
    [self hide:YES afterDelay:afterSecond];
}

- (void)xm_hideWithTitle:(NSString *)title
                hideAfter:(NSTimeInterval)afterSecond
                  msgType:(XMMBProgressHUDMsgType)msgType {
    self.labelText = title;
    self.mode = MBProgressHUDModeCustomView;
    self.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[self class ] xm_imageNamedWithMsgType:msgType]]];
    [self hide:YES afterDelay:afterSecond];
}

+ (MBProgressHUD *)xm_showTitle:(NSString *)title toView:(UIView *)view hideAfter:(NSTimeInterval)afterSecond {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelFont = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.labelText = title;
    HUD.opacity = OPACITY;
    [HUD hide:YES afterDelay:afterSecond];
    return HUD;
}

+ (MBProgressHUD *)xm_showTitle:(NSString *)title
                          toView:(UIView *)view
                       hideAfter:(NSTimeInterval)afterSecond
                         msgType:(XMMBProgressHUDMsgType)msgType {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.labelFont = [UIFont systemFontOfSize:FONT_SIZE];
    
    NSString *imageNamed = [self xm_imageNamedWithMsgType:msgType];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    HUD.labelText = title;
    HUD.opacity = OPACITY;
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD hide:YES afterDelay:afterSecond];
    return HUD;
    
}

+ (NSString *)xm_imageNamedWithMsgType:(XMMBProgressHUDMsgType)msgType {
    NSString *imageNamed = nil;
    if (msgType == XMMBProgressHUDMsgTypeSuccessful) {
        imageNamed = @"bwm_hud_success";
    } else if (msgType == XMMBProgressHUDMsgTypeError) {
        imageNamed = @"bwm_hud_error";
    } else if (msgType == XMMBProgressHUDMsgTypeWarning) {
        imageNamed = @"bwm_hud_warning";
    } else if (msgType == XMMBProgressHUDMsgTypeInfo) {
        imageNamed = @"bwm_hud_info";
    }
    return imageNamed;
}

+ (MBProgressHUD *)xm_showDeterminateHUDTo:(UIView *)view {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.labelText = XMMBProgressHUDMsgLoading;
    HUD.labelFont = [UIFont systemFontOfSize:FONT_SIZE];
    return HUD;
}

+ (void)xm_setHideTimeInterval:(NSTimeInterval)second fontSize:(CGFloat)fontSize opacity:(CGFloat)opacity {
    XMMBProgressHUDHideTimeInterval = second;
    FONT_SIZE = fontSize;
    OPACITY = opacity;
}


@end
