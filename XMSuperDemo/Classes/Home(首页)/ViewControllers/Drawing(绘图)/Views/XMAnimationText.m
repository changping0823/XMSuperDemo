//
//  XMAnimationText.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/4.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMAnimationText.h"
#import <CoreText/CoreText.h>

@interface XMAnimationText()

@property (nonatomic, retain) CAShapeLayer *pathLayer;
@property (nonatomic, retain) CALayer *penLayer;

@end

@implementation XMAnimationText

+(void)createAnimationLayerWithString:(NSString*)string andRect:(CGRect)rect andView:(UIView *)view andFont:(UIFont*)ui_font andStrokeColor:(UIColor*)color{
    
    XMAnimationText * animationLayer = [XMAnimationText layer];
    animationLayer.frame = rect;
    [view.layer addSublayer:animationLayer];
    
    if (animationLayer.pathLayer != nil) {
        [animationLayer.penLayer removeFromSuperlayer];
        [animationLayer.pathLayer removeFromSuperlayer];
        animationLayer.pathLayer = nil;
        animationLayer.penLayer = nil;
    }
    
    CTFontRef font =CTFontCreateWithName((CFStringRef)ui_font.fontName,ui_font.pointSize,NULL);
    CGMutablePathRef letters = CGPathCreateMutable();
    
    //这里设置画线的字体和大小
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)font, kCTFontAttributeName,nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
//    line.li
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++){
        // Get FONT for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        // for each GLYPH in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++){
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    CFRelease(font);
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = animationLayer.bounds;
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [color CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 1.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    [animationLayer addSublayer:pathLayer];
    animationLayer.pathLayer = pathLayer;
    
    [animationLayer.pathLayer removeAllAnimations];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 5.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [animationLayer.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];

}

@end










