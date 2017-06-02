//
//  XMTools.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/8.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMTools.h"
#import  <AssetsLibrary/AssetsLibrary.h>


#define kAlbumName @"O(∩_∩)O~"


static XMTools *_instance;

@implementation XMTools


+ (XMTools *)sharedXMTools{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


#pragma mark - 在手机相册中创建相册

- (void)createAlbumInPhoneAlbum:(UIImage *)image complete:(SuccessBlock)success{
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    NSMutableArray *groups=[[NSMutableArray alloc]init];
    
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop){
        if (group){
            [groups addObject:group];
        }else{
            
            BOOL haveHDRGroup = NO;
            
            for (ALAssetsGroup *gp in groups){
                NSString *name =[gp valueForProperty:ALAssetsGroupPropertyName];
                
                if ([name isEqualToString:kAlbumName]){
                    haveHDRGroup = YES;
                }
            }
            
            if (!haveHDRGroup){
                [assetsLibrary addAssetsGroupAlbumWithName:kAlbumName resultBlock:^(ALAssetsGroup *group){
                    [groups addObject:group];
                }failureBlock:nil];
                
                haveHDRGroup = YES;
            }
            
        }
        
    };
    
    //创建相簿
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:listGroupBlock failureBlock:nil];
    
    //保存图片
    [self saveToAlbumWithMetadata:nil imageData:UIImagePNGRepresentation(image) customAlbumName:kAlbumName completionBlock:^{
        
        //这里可以创建添加成功的方法
        success(YES);
        
    }failureBlock:^(NSError *error){
        success(NO);
        //处理添加失败的方法
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //添加失败一般是由用户不允许应用访问相册造成的，这边可以取出这种情况加以判断一下
            
            if([error.localizedDescription rangeOfString:@"User denied access"].location != NSNotFound ||[error.localizedDescription rangeOfString:@"用户拒绝访问"].location!=NSNotFound){
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:error.localizedDescription message:error.localizedFailureReason delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles: nil];
                
                [alert show];
                
            }
            
        });
        
    }];
    
}


- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata
                      imageData:(NSData *)imageData
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(void))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock{
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    void (^AddAsset)(ALAssetsLibrary *, NSURL *) = ^(ALAssetsLibrary *assetsLibrary, NSURL *assetURL) {
        
        [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:customAlbumName]){
                    
                    [group addAsset:asset];
                    
                    if (completionBlock) {
                        completionBlock();
                    }
                }
                
            } failureBlock:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
            
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
        
    };
    
    __weak ALAssetsLibrary* weakSelf = assetsLibrary;
    
    [assetsLibrary writeImageDataToSavedPhotosAlbum:imageData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        
        if (customAlbumName) {
            
            [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName resultBlock:^(ALAssetsGroup *group) {
                
                if (group) {
                    [weakSelf assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                        [group addAsset:asset];
                        
                        if (completionBlock) {
                            completionBlock();
                        }
                        
                    } failureBlock:^(NSError *error) {
                        if (failureBlock) {
                            failureBlock(error);
                        }
                    }];
                    
                } else {
                    AddAsset(weakSelf, assetURL);
                }
                
            } failureBlock:^(NSError *error) {
                
                AddAsset(weakSelf, assetURL);
            }];
            
        } else {
            if (completionBlock) {
                completionBlock();
            }
        }
    }];
    
}



/** 保存视频到相册 */
- (void)writeVideoAtPathToSavedPhotosAlbum:(NSURL *)url complete:(SuccessBlock)success{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:url]){
        [library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error){
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (error) {
                    success(NO);
                } else {
                    success(YES);
                }
            });
        }];
    }

}


@end
