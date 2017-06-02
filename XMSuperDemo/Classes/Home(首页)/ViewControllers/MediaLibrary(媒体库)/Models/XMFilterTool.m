//
//  XMFilterTool.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/8.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMFilterTool.h"
#import <GPUImage.h>

static XMFilterTool *_sharedInstance = nil;

@implementation XMFilterTool

+ (XMFilterTool *)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[XMFilterTool alloc]init];
    });
    return _sharedInstance;
}


// 滤镜
- (UIImage *)imageByFilteringImage:(UIImage *)inImage filterType:(GPUImageColormatrixFilterType)filterType{
    return [[self filterType:filterType] imageByFilteringImage:inImage];
}
-(IFImageFilter *)filterType:(GPUImageColormatrixFilterType)filterType{
    IFImageFilter *filter = [[IFImageFilter alloc] init];
    
    switch (filterType) {
        case GPUImageColormatrixFilterTypeORI:
            filter = [[IFNormalFilter alloc]init];
            break;
        case 1:
            filter = [[IF1977Filter alloc] init];
            break;
        case 2:
            filter = [[IFAmaroFilter alloc] init];
            break;
        case GPUImageColormatrixFilterTypeGETE:
            filter = [[IFBrannanFilter alloc] init];
            break;
        case 4:
            filter = [[IFEarlybirdFilter alloc] init];
            break;
        case 5:
            filter = [[IFHefeFilter alloc] init];
            break;
        case 6:
            filter = [[IFHudsonFilter alloc] init];
            break;
        case GPUImageColormatrixFilterTypeHEIBAI:
            filter = [[IFInkwellFilter alloc] init];
            break;
        case 8:
            filter = [[IFLomofiFilter alloc] init];
            break;
        case 9:
            filter = [[IFLordKelvinFilter alloc] init];
            break;
        case 10:
            filter = [[IFNashvilleFilter alloc] init];
            break;
        case GPUImageColormatrixFilterTypeMENGHUAN:
            filter = [[IFSutroFilter alloc] init];
            break;
        case 12:
            filter = [[IFRiseFilter alloc] init];
            break;
        case 13:
            filter = [[IFSierraFilter alloc] init];
            break;
        default:
            break;
    }
    return filter;
}
-(NSArray *)getFilters:(SuccessBlock)block{
    
    NSMutableArray * array = [NSMutableArray array];
    
    for (int i = 0; i < 14; i++) {
        XMFilterModel * model = [[XMFilterModel alloc]init];
        GPUImageColormatrixFilterType filterType = [[XMFilterTool sharedInstance] colormatrixFilterTypeByIndex:i];
        model.name = [[XMFilterTool sharedInstance] getFilterName:filterType];
        model.type = filterType;
        model.thumbnailImage = [[XMFilterTool sharedInstance] imageByFilteringImage:[UIImage imageNamed:@"camera_filter"] filterType:filterType];
        [array addObject:model];
    }
    block(YES);
    return array;
}

- (GPUImageColormatrixFilterType)colormatrixFilterTypeByIndex:(NSInteger)index{
    GPUImageColormatrixFilterType filterType = GPUImageColormatrixFilterTypeORI;
    
    switch (index) {
        case 0:
            filterType = GPUImageColormatrixFilterTypeORI;
            break;
        case 1:
            filterType = GPUImageColormatrixFilterTypeFUGU;
            break;
        case 2:
            filterType = GPUImageColormatrixFilterTypeDANYA;
            break;
        case 3:
            filterType = GPUImageColormatrixFilterTypeHEIBAI;
            break;
        case 4:
            filterType = GPUImageColormatrixFilterTypeLANGMAN;
            break;
        case 5:
            filterType = GPUImageColormatrixFilterTypeJIUHONG;
            break;
        case 6:
            filterType = GPUImageColormatrixFilterTypeRUISE;
            break;
        case 7:
            filterType = GPUImageColormatrixFilterTypeGETE;
            break;
        case 8:
            filterType = GPUImageColormatrixFilterTypeLANDIAO;
            break;
        case 9:
            filterType = GPUImageColormatrixFilterTypeQINGNING;
            break;
        case 10:
            filterType = GPUImageColormatrixFilterTypeGUANGYUN;
            break;
        case 11:
            filterType = GPUImageColormatrixFilterTypeMENGHUAN;
            break;
        case 12:
            filterType = GPUImageColormatrixFilterTypeYESE;
            break;
        case 13:
            filterType = GPUImageColormatrixFilterTypeLOMO;
            break;
        default:
            break;
    }
    return filterType;
}
- (NSString *)getFilterName:(GPUImageColormatrixFilterType)filterType {
    NSString *title = @"";
    switch (filterType) {
        case GPUImageColormatrixFilterTypeORI:
            title = @"原图";
            break;
        case GPUImageColormatrixFilterTypeLOMO:
            title = @"布拉格";
            break;
        case GPUImageColormatrixFilterTypeHEIBAI:
            title = @"黑白";
            break;
        case GPUImageColormatrixFilterTypeFUGU:
            title = @"复古";
            break;
        case GPUImageColormatrixFilterTypeGETE:
            title = @"暖暖";
            break;
        case GPUImageColormatrixFilterTypeRUISE:
            title = @"流年";
            break;
        case GPUImageColormatrixFilterTypeDANYA:
            title = @"胶片";
            break;
        case GPUImageColormatrixFilterTypeJIUHONG:
            title = @"美食";
            break;
        case GPUImageColormatrixFilterTypeQINGNING:
            title = @"少女";
            break;
        case GPUImageColormatrixFilterTypeLANGMAN:
            title = @"薄暮";
            break;
        case GPUImageColormatrixFilterTypeGUANGYUN:
            title = @"时光";
            break;
        case GPUImageColormatrixFilterTypeLANDIAO:
            title = @"白露";
            break;
        case GPUImageColormatrixFilterTypeMENGHUAN:
            title = @"维也纳";
            break;
        case GPUImageColormatrixFilterTypeYESE:
            title = @"夜色";
            break;
        default:
            break;
    }
    return title;
}


@end
