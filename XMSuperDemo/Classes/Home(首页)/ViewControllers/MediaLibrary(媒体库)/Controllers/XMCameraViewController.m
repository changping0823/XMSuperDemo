//
//  XMCameraViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMCameraViewController.h"
#import <GPUImage.h>

#import "XMFireView.h"
#import "XMCameraView.h"
#import "XMFilterShowView.h"


#define kVideoPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LiveMovied.m4v"]


@interface XMCameraViewController ()<XMCameraDelegate>

@property(nonatomic, strong)XMCameraView *cameraView;
@property(nonatomic, strong)XMFireView *filterView;
@property(nonatomic, strong)XMFilterShowView *showView;


@property (nonatomic,strong)GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic,strong)GPUImageView *filterImageView;
@property (nonatomic,strong)GPUImageStillCamera *stillCamera;
@property(nonatomic, strong)GPUImageMovieWriter *movieWriter;
@property(nonatomic, strong)NSURL *movieURL;

@end

@implementation XMCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    unlink([kVideoPath UTF8String]);
    self.movieURL = [NSURL fileURLWithPath:kVideoPath];
    self.stillCamera = [[GPUImageStillCamera alloc] init];
    
    if (SCREEN_HEIGHT == 480) {
        self.stillCamera.captureSessionPreset = AVCaptureSessionPreset640x480;
    }else if(SCREEN_HEIGHT == 568 || SCREEN_HEIGHT == 667){
        self.stillCamera.captureSessionPreset = AVCaptureSessionPreset1280x720;
    }
    self.stillCamera.captureSessionPreset = AVCaptureSessionPreset1920x1080;

    self.stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    // 初始化滤镜(默认滤镜为原图)
    self.filter = [[IFNormalFilter alloc] init];
    
    // 添加滤镜显示视图
    self.filterImageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    self.filterImageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    [self.view addSubview:self.filterImageView];
    [self.filter addTarget:self.filterImageView];

    [self.stillCamera rotateCamera];
    // 添加滤镜
    [self.stillCamera addTarget:self.filter];
    
    // 开始捕获
    [self.stillCamera startCameraCapture];
    
    [self.view addSubview:self.cameraView];
    
    
    return;
    
}

#pragma mark - XMCameraDelegate

-(void)xm_cameraView:(XMCameraView *)view selectFilter:(XMFilterModel *)filter{
    [self.stillCamera removeTarget:self.filter];
    self.filter = [[XMFilterTool sharedInstance] filterType:filter.type];
    [self.filter addTarget:self.filterImageView];
    [self.stillCamera addTarget:self.filter];
}
-(void)xm_cameraViewCancel:(XMCameraView *)view{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)xm_cameraView:(XMCameraView *)view rotateCamera:(BOOL)rotate{
    [self.stillCamera rotateCamera];
}
-(void)xm_cameraViewTakephotos:(XMCameraView *)view{

    [self.stillCamera capturePhotoAsImageProcessedUpToFilter:self.filter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        [self.showView showImage:processedImage];
    }];
}

-(void)xm_cameraViewTakeVideo:(XMCameraView *)view stauts:(XMCameraButtonStatus)status{
    
    
    if (status == XMCameraButtonStatus_start) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.movieWriter startRecording];
        });
    }else if (status == XMCameraButtonStatus_end){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.stillCamera.audioEncodingTarget = nil;
            [self.filter removeTarget:self.movieWriter];
            [self.movieWriter finishRecording];
            [self.showView showVideo:self.movieURL];

        });
        
    }
}



-(XMCameraView *)cameraView{
    if (!_cameraView) {
        _cameraView = [[XMCameraView alloc]init];
        _cameraView.delegate = self;
    }
    return _cameraView;
}
-(XMFilterShowView *)showView{
    if (!_showView) {
        _showView = [[XMFilterShowView alloc]init];
    }
    return _showView;
}
-(GPUImageMovieWriter *)movieWriter{
    if (!_movieWriter) {
        _movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:self.movieURL size:self.view.size];
        //设置为liveVideo
        _movieWriter.encodingLiveVideo = YES;
        [self.filter addTarget:_movieWriter];
    }
    return _movieWriter;
}

-(void)dealloc{
    NSLog(@"XMCameraViewController ----  dealloc");
}


@end














