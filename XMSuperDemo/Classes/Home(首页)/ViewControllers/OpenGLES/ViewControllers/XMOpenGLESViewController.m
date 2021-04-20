//
//  XMOpenGLESViewController.m
//  XMSuperDemo
//
//  Created by Charles on 2021/4/20.
//  Copyright © 2021 任长平. All rights reserved.
//

#import "XMOpenGLESViewController.h"
#import <GLKit/GLKit.h>

@interface XMOpenGLESViewController ()
@property (nonatomic, strong) EAGLContext *mContext;
@end

@implementation XMOpenGLESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupConfig];
}
- (void)setupConfig{
    self.mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    GLKView* view = [[GLKView alloc] initWithFrame:self.view.bounds context:self.mContext]; //storyboard记得添加
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;  //颜色缓冲区格式
    [EAGLContext setCurrentContext:self.mContext];
}

@end
