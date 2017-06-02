//
//  XMStatusCell.h
//  XMSuperDemo
//
//  Created by 任长平 on 2016/12/13.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XMStatuses.h"

@interface XMStatusCell : UITableViewCell
@property (nonatomic, strong) XMStatuses *status;


+ (CGFloat)heightWithModel:(XMStatuses *)status;
+(instancetype)createTableViewCell:(UITableView *)tableView;
@end
