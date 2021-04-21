//
//  XMVertexAttribArrayBuffer.h
//  XMSuperDemo
//
//  Created by Charles on 2021/4/21.
//  Copyright © 2021 任长平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMVertexAttribArrayBuffer : NSObject

- (instancetype)initWithAttribStride:(GLsizei)stride
                    numberOfVertices:(GLsizei)count
                                data:(const GLvoid *)data
                               usage:(GLenum)usage;

- (void)prepareToDrawWithAttrib:(GLuint)index
            numberOfCoordinates:(GLint)count
                   attribOffset:(GLsizeiptr)offset
                   shouldEnable:(BOOL)shouldEnable;

- (void)drawArrayWithMode:(GLenum)mode
         startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count;

- (void)updateDataWithAttribStride:(GLsizei)stride
                  numberOfVertices:(GLsizei)count
                              data:(const GLvoid *)data
                             usage:(GLenum)usage;
@end

NS_ASSUME_NONNULL_END
