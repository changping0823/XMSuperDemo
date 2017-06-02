//
//  XMTools.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/8.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(BOOL success);

@interface XMTools : NSObject
+ (XMTools *)sharedXMTools;

/** 保存图片到相册 */
- (void)createAlbumInPhoneAlbum:(UIImage *)image complete:(SuccessBlock)success;
/** 保存视频到相册 */
- (void)writeVideoAtPathToSavedPhotosAlbum:(NSURL *)url complete:(SuccessBlock)success;

@end
