//
//  XMMediaLibraryViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/4.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMMediaLibraryViewController.h"
#import "HJImagesToVideo.h"
#import "XMPlayerView.h"
#import "XMFilterViewController.h"          //滤镜
#import "XMCameraViewController.h"
#import <TZImagePickerController.h>

#import "ACAlertController.h"

@interface XMMediaLibraryViewController ()
<
XMPlayerViewDelegate,
TZImagePickerControllerDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>




@property(nonatomic, strong)XMPlayerView *xm_player;

@end

@implementation XMMediaLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self playVideo];
    
    
    [self filter];
    
//    TZImagePickerController *imagePC=[[TZImagePickerController alloc]initWithMaxImagesCount:15 delegate:self];
//    [self presentViewController:imagePC animated:YES completion:nil];//跳转

}

-(void)filter{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.size = CGSizeMake(80, 44);
    button.center = self.view.center;
    button.backgroundColor = [UIColor RandomColor];
    [button setTitle:@"滤镜" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(filterButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
-(void)filterButtonClick{
    
    ACAlertController * alert = [[ACAlertController alloc]initWithActionSheetTitles:@[@"相册",@"拍照"]
                                                                        cancelTitle:@"取消"];
    [alert clickActionButton:^(NSInteger index) {
        NSUInteger sourceType = 0;
        
        switch (index) {
            case 0://相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 1:{//拍照
                XMCameraViewController * cameraVC = [[XMCameraViewController alloc]init];
                [self presentViewController:cameraVC animated:YES completion:nil];
                return ;
            }
                break;
            default:
                break;
        }
        
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
        //设置图像选取控制器的来源模式为相机模式
        imagePickerController.sourceType = sourceType;
        //设置委托对象
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }];
    [alert show];

    

}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *editedImge = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    XMFilterViewController * filterVC = [[XMFilterViewController alloc]init];
    filterVC.image = editedImge;
    XMNavigationController * nav = [[XMNavigationController alloc]initWithRootViewController:filterVC];
    [self presentViewController:nav animated:YES completion:nil];
    
}





- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    NSLog(@"photos == %@",photos);
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"Documents/movie.mp4"]];
    
    NSMutableArray * array = [NSMutableArray array];
    for (UIImage * image in photos) {
        [array addObject:image];
    }
    
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];

    
    [HJImagesToVideo videoFromImages:array toPath:path animateTransitions:YES withCallbackBlock:^(BOOL success) {
        NSLog(@"Success");
        [self playVideo:path];
    }];

}




-(void)playVideo:(NSString *)path{
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
//    NSString *path = @"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA";
    
    self.xm_player = [[XMPlayerView alloc] initWithUrl:path delegate:self];
    self.xm_player.delegate = self;
    self.xm_player.frame = self.view.bounds;
    [self.view addSubview:self.xm_player];
}


@end
