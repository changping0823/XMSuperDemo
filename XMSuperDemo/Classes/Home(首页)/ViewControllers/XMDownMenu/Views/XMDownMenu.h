//
//  XMDownMenu.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/6/29.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMDownMenu;


@protocol XMDownMenuDataSource <NSObject>

-(NSInteger)titltNumberOfDownMenu:(XMDownMenu *)menu;

@end

@protocol XMDownMenuDelegate <NSObject>

-(void)hiddenDownMenu:(XMDownMenu *)menu;
-(void)xm_downMenu:(XMDownMenu *)menu didSelectTitleAtTitleNumber:(NSInteger)number;

@end

@interface XMDownMenu : UIView

@property(nonatomic, weak)id<XMDownMenuDelegate> delegate;
@property(nonatomic, weak)id<XMDownMenuDataSource> dataSource;

-(void)reload;

@end
