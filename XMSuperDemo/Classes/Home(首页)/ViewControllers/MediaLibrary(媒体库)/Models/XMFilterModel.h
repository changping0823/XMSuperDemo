//
//  XMFilterModel.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/8.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GPUImageColormatrixFilterType) {
    GPUImageColormatrixFilterTypeORI = 0,   // 原图
    GPUImageColormatrixFilterTypeFUGU,      // 鲜亮
    GPUImageColormatrixFilterTypeDANYA,     // 胶片
    GPUImageColormatrixFilterTypeHEIBAI,    // 黑白
    GPUImageColormatrixFilterTypeLANGMAN,   // 薄暮
    GPUImageColormatrixFilterTypeJIUHONG,   // 美食
    GPUImageColormatrixFilterTypeRUISE,     // 流年
    GPUImageColormatrixFilterTypeGETE,      // 暖暖
    GPUImageColormatrixFilterTypeLANDIAO,   // 白露
    GPUImageColormatrixFilterTypeQINGNING,  // 少女
    GPUImageColormatrixFilterTypeGUANGYUN,  // 时光
    GPUImageColormatrixFilterTypeMENGHUAN,  // 维也纳
    GPUImageColormatrixFilterTypeYESE,      // 夜色
    GPUImageColormatrixFilterTypeLOMO,      // 布拉格
};


@interface XMFilterModel : NSObject
@property(nonatomic, assign)GPUImageColormatrixFilterType type;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, strong)UIImage *thumbnailImage;
@end
