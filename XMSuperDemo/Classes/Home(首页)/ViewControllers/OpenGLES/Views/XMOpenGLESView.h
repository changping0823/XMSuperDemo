//
//  XMOpenGLESView.h
//  XMSuperDemo
//
//  Created by Charles on 2021/4/21.
//  Copyright © 2021 任长平. All rights reserved.
//


#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMOpenGLESView : GLKView
/// 拉伸区域是否被拉伸
@property (nonatomic, assign, readonly) BOOL hasChange;
/**
 更新图片
 */
- (void)updateImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
