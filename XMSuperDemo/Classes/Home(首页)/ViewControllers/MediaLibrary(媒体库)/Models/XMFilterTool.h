//
//  XMFilterTool.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/8.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "InstaFilters.h"
#import "XMFilterModel.h"



typedef void(^SuccessBlock)(BOOL success);


@interface XMFilterTool : NSObject
+ (XMFilterTool *)sharedInstance;

-(IFImageFilter *)filterType:(GPUImageColormatrixFilterType)filterType;
// 滤镜
- (UIImage *)imageByFilteringImage:(UIImage *)inImage filterType:(GPUImageColormatrixFilterType)filterType;


-(NSArray *)getFilters:(SuccessBlock)block;

@end
