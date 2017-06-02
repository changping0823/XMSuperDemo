//
//  XMButton.h
//  XMSuperDemo
//
//  Created by 任长平 on 16/8/3.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger{
    /** 默认图片在左 */
    BUTTON_STYLE_LEFT = 0,
    /** 图片在右 */
    BUTTON_STYLE_RIGHT = 1,
    /** 图片在上文字在下居中 */
    BUTTON_STYLE_TOP = 2,
    /** 图片在下文字在上居中 */
    BUTTON_STYLE_BOTTOM = 3,
    
}BUTTON_STYLE;

@interface XMButton : UIButton

@property (nonatomic, assign) BUTTON_STYLE buttonStyle;
/** 文字和图片的间距 */
@property (nonatomic, assign) CGFloat space;


- (instancetype)initWithStyle:(BUTTON_STYLE)style;


@end
