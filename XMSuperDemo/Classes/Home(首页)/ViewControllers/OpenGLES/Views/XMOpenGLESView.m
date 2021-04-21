//
//  XMOpenGLESView.m
//  XMSuperDemo
//
//  Created by Charles on 2021/4/21.
//  Copyright © 2021 任长平. All rights reserved.
//

#import "XMOpenGLESView.h"
#import "XMVertexAttribArrayBuffer.h"

/// 初始纹理高度占控件高度的比例
static CGFloat const kDefaultOriginTextureHeight = 0.7f;
/// 顶点数量
static NSInteger const kVerticesCount = 8;

typedef struct {
    GLKVector3 positionCoord;
    GLKVector2 textureCoord;
}SenceVertex;


@interface XMOpenGLESView ()<GLKViewDelegate>

/// 拉伸区域是否被拉伸
@property (nonatomic, assign, readwrite) BOOL hasChange;

@property (nonatomic, assign) CGSize currentImageSize;
@property (nonatomic, assign) CGFloat currentTextureWidth;

@property (nonatomic, strong) GLKBaseEffect *baseEffect;
@property (nonatomic, assign) SenceVertex *vertices;
@property (nonatomic, strong) XMVertexAttribArrayBuffer *vertexAttribArrayBuffer;

// 用于重新绘制纹理
@property (nonatomic, assign) CGFloat currentTextureStartY;
@property (nonatomic, assign) CGFloat currentTextureEndY;
@property (nonatomic, assign) CGFloat currentNewHeight;
@end

@implementation XMOpenGLESView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ([super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.vertices = malloc(sizeof(SenceVertex) *kVerticesCount);
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    self.delegate = self;
    
    EAGLContext.currentContext = self.context;
    glClearColor(0.6f, 0.0f, 0.0f, 1.0f);
    
    self.vertexAttribArrayBuffer = [[XMVertexAttribArrayBuffer alloc] initWithAttribStride:sizeof(SenceVertex) numberOfVertices:kVerticesCount data:self.vertices usage:GL_STATIC_DRAW];
}

- (void)updateImage:(UIImage *)image {
    self.hasChange = NO;
    
    NSDictionary *options = @{GLKTextureLoaderOriginBottomLeft : @(YES)};
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithCGImage:[image CGImage]
                                                               options:options
                                                                 error:NULL];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.texture2d0.name = textureInfo.name;
    
    self.currentImageSize = image.size;

    CGFloat ratio = (self.currentImageSize.height / self.currentImageSize.width) *
    (self.bounds.size.width / self.bounds.size.height);
    CGFloat textureHeight = MIN(ratio, kDefaultOriginTextureHeight);
    self.currentTextureWidth = textureHeight / ratio;
    
    [self calculateOriginTextureCoordWithTextureSize:self.currentImageSize
                                              startY:0
                                                endY:0
                                           newHeight:0];
    [self.vertexAttribArrayBuffer updateDataWithAttribStride:sizeof(SenceVertex)
                                            numberOfVertices:kVerticesCount
                                                        data:self.vertices
                                                       usage:GL_STATIC_DRAW];
    [self display];
}
/**
 根据当前控件的尺寸和纹理的尺寸，计算初始纹理坐标

 @param size 原始纹理尺寸
 @param startY 中间区域的开始纵坐标位置 0~1
 @param endY 中间区域的结束纵坐标位置 0~1
 @param newHeight 新的中间区域的高度
 */
- (void)calculateOriginTextureCoordWithTextureSize:(CGSize)size
                                            startY:(CGFloat)startY
                                              endY:(CGFloat)endY
                                         newHeight:(CGFloat)newHeight{
    CGFloat ratio = (size.height / size.width) *
                    (self.bounds.size.width / self.bounds.size.height);
    CGFloat textureWidth = self.currentTextureWidth;
    CGFloat textureHeight = textureWidth * ratio;
    // 拉伸量
    CGFloat delta = (newHeight - (endY -  startY)) * textureHeight;
    
    // 判断是否超出最大值
    if (textureHeight + delta >= 1) {
        delta = 1 - textureHeight;
        newHeight = delta / textureHeight + (endY -  startY);
    }
    
    // 纹理的顶点
    GLKVector3 pointLT = {-textureWidth, textureHeight + delta, 0};  // 左上角
    GLKVector3 pointRT = {textureWidth, textureHeight + delta, 0};  // 右上角
    GLKVector3 pointLB = {-textureWidth, -textureHeight - delta, 0};  // 左下角
    GLKVector3 pointRB = {textureWidth, -textureHeight - delta, 0};  // 右下角
    
    // 中间矩形区域的顶点
    CGFloat startYCoord = MIN(-2 * textureHeight * startY + textureHeight, textureHeight);
    CGFloat endYCoord = MAX(-2 * textureHeight * endY + textureHeight, -textureHeight);
    GLKVector3 centerPointLT = {-textureWidth, startYCoord + delta, 0};  // 左上角
    GLKVector3 centerPointRT = {textureWidth, startYCoord + delta, 0};  // 右上角
    GLKVector3 centerPointLB = {-textureWidth, endYCoord - delta, 0};  // 左下角
    GLKVector3 centerPointRB = {textureWidth, endYCoord - delta, 0};  // 右下角
    
    // 纹理的上面两个顶点
    self.vertices[0].positionCoord = pointLT;
    self.vertices[0].textureCoord = GLKVector2Make(0, 1);
    self.vertices[1].positionCoord = pointRT;
    self.vertices[1].textureCoord = GLKVector2Make(1, 1);
    // 中间区域的4个顶点
    self.vertices[2].positionCoord = centerPointLT;
    self.vertices[2].textureCoord = GLKVector2Make(0, 1 - startY);
    self.vertices[3].positionCoord = centerPointRT;
    self.vertices[3].textureCoord = GLKVector2Make(1, 1 - startY);
    self.vertices[4].positionCoord = centerPointLB;
    self.vertices[4].textureCoord = GLKVector2Make(0, 1 - endY);
    self.vertices[5].positionCoord = centerPointRB;
    self.vertices[5].textureCoord = GLKVector2Make(1, 1 - endY);
    // 纹理的下面两个顶点
    self.vertices[6].positionCoord = pointLB;
    self.vertices[6].textureCoord = GLKVector2Make(0, 0);
    self.vertices[7].positionCoord = pointRB;
    self.vertices[7].textureCoord = GLKVector2Make(1, 0);
    
    // 保存临时值
    self.currentTextureStartY = startY;
    self.currentTextureEndY = endY;
    self.currentNewHeight = newHeight;
}
#pragma mark - >>>>>>>>>>>>>>>> GLKViewDelegate <<<<<<<<<<<<<<<
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [self.baseEffect prepareToDraw];
    
    glClear(GL_COLOR_BUFFER_BIT);
    
    [self.vertexAttribArrayBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
                                      numberOfCoordinates:3
                                             attribOffset:offsetof(SenceVertex, positionCoord)
                                             shouldEnable:YES];
    
    [self.vertexAttribArrayBuffer prepareToDrawWithAttrib:GLKVertexAttribTexCoord0
                                      numberOfCoordinates:2
                                             attribOffset:offsetof(SenceVertex, textureCoord)
                                             shouldEnable:YES];
    
    [self.vertexAttribArrayBuffer drawArrayWithMode:GL_TRIANGLE_STRIP
                                   startVertexIndex:0
                                   numberOfVertices:kVerticesCount];
}
@end
