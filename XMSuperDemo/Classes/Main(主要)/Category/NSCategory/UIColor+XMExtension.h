//
//  UIColor+XMExtension.h
//  XMSuperDemo
//
//  Created by 任长平 on 2016/11/18.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XMExtension)

+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

+ (UIColor *)colorWithMacHex:(UInt32)hex;
+ (UIColor *)colorWithMacHex:(UInt32)hex andAlpha:(CGFloat)alpha;
/**
 *   用HexString 生成 UIColor
 *
 *  @param hexString   #RGB  #ARGB   #RRGGBB  #AARRGGBB 或者不带#
 */
+ (UIColor *)colorWithMacHexString:(NSString *)hexString;
/**
 *  当前UIColor用的HexString
 */
- (NSString *)MacHEXString;
/**
 *  当前UIColor用的RGB(255,255,255,1.0) 用纯数字
 */
+ (UIColor *)colorWithMacWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue
                            alpha:(CGFloat)alpha;


/**
 *  @brief  随机颜色
 *
 *  @return UIColor
 */
+ (UIColor *)RandomColor;

/**
 *  @brief  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;

@end
