//
//  UINavigationBar+Extension.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/6/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "UINavigationBar+Extension.h"
#import <objc/runtime.h>



@implementation UINavigationBar (Extension)

static char xm_overlayKey;

- (UIView *)xm_overlay
{
    return objc_getAssociatedObject(self, &xm_overlayKey);
}

- (void)setXm_overlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &xm_overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xm_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.xm_overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.xm_overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.xm_overlay.userInteractionEnabled = NO;
        self.xm_overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.xm_overlay atIndex:0];
    }
    self.xm_overlay.backgroundColor = backgroundColor;
}

- (void)xm_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)xm_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)xm_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.xm_overlay removeFromSuperview];
    self.xm_overlay = nil;
}

@end
