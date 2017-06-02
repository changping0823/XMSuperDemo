//
//  XMKeyboardTool.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/4/25.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMKeyboardTool.h"

@interface XMKeyboardTool ()
@property(nonatomic, strong)UIView *lineView;

@end

@implementation XMKeyboardTool

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1];
        [self addSubview:self.lineView];
        
        UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:@selector(resignKeyboard:)];
        
        UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:@selector(resignKeyboard:)];
        
        //定义完成按钮
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成"
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(resignKeyboard:)];
        button1.tag = 0;
        button2.tag = 1;
        doneButton.tag = 2;
        NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
        
        [self setItems:buttonsArray];
    }
    return self;
}

-(void)resignKeyboard:(UIBarButtonItem *)buttonItem{
    if (self.toolBlock) {
        self.toolBlock(buttonItem.tag);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.lineView.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}


@end
