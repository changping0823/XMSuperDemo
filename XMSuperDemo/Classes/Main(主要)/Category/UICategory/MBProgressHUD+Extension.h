//
//  MBProgressHUD+Extension.h
//  XMSuperDemo
//
//  Created by 任长平 on 2016/11/16.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Extension)

extern NSString * const XMMBProgressHUDMsgLoading;
extern NSString * const XMMBProgressHUDMsgLoadError;
extern NSString * const XMMBProgressHUDMsgLoadSuccessful;
extern NSString * const XMMBProgressHUDMsgNoMoreData;
extern NSTimeInterval   XMMBProgressHUDHideTimeInterval;


typedef NS_ENUM(NSUInteger, XMMBProgressHUDMsgType) {
    XMMBProgressHUDMsgTypeSuccessful,
    XMMBProgressHUDMsgTypeError,
    XMMBProgressHUDMsgTypeWarning,
    XMMBProgressHUDMsgTypeInfo
};




/**
 *  @brief  添加一个带菊花的HUD
 *
 *  @param view  目标view
 *  @param title 标题
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)xm_showHUDAddedTo:(UIView *)view title:(NSString *)title;
/** 添加一个带菊花的HUD */
+ (MBProgressHUD *)xm_showHUDAddedTo:(UIView *)view
                               title:(NSString *)title
                            animated:(BOOL)animated;

/**
 *  @brief  隐藏指定的HUD
 *
 *  @param afterSecond 多少秒后
 */
- (void)xm_hideAfter:(NSTimeInterval)afterSecond;
/** 隐藏指定的HUD */
- (void)xm_hideWithTitle:(NSString *)title
               hideAfter:(NSTimeInterval)afterSecond;
/** 隐藏指定的HUD */
- (void)xm_hideWithTitle:(NSString *)title
               hideAfter:(NSTimeInterval)afterSecond
                 msgType:(XMMBProgressHUDMsgType)msgType;

/**
 *  @brief  显示一个自定的HUD
 *
 *  @param title       标题
 *  @param view        目标view
 *  @param afterSecond 持续时间
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)xm_showTitle:(NSString *)title
                         toView:(UIView *)view
                      hideAfter:(NSTimeInterval)afterSecond;
/** 显示一个自定的HUD */
+ (MBProgressHUD *)xm_showTitle:(NSString *)title
                         toView:(UIView *)view
                      hideAfter:(NSTimeInterval)afterSecond
                        msgType:(XMMBProgressHUDMsgType)msgType;

/**
 *  @brief  显示一个渐进式的HUD
 *
 *  @param view 目标view
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)xm_showDeterminateHUDTo:(UIView *)view;

/** 配置本扩展的默认参数 */
+ (void)xm_setHideTimeInterval:(NSTimeInterval)second fontSize:(CGFloat)fontSize opacity:(CGFloat)opacity;





@end
