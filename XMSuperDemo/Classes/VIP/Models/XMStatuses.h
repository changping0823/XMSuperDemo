//
//  XMStatus.h
//  XMSuperDemo
//
//  Created by 任长平 on 16/5/20.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    /** 没有任何认证 */
    XMUserVerifiedTypeNone = -1,
    /** 个人认证*/
    XMUserVerifiedPersonal = 0,
    /** 企业官方：CSDN、EOE、搜狐新闻客户端 */
    XMUserVerifiedOrgEnterprice = 2,
    /** 媒体官方：程序员杂志、苹果汇*/
    XMUserVerifiedOrgMedia = 3,
    /** 网站官方：猫扑 */
    XMUserVerifiedOrgWebsite = 5,
    /** 微博达人*/
    XMUserVerifiedDaren = 220
} XMUserVerifiedType;


@class StatusUser;
@interface XMStatuses : NSObject

/**	string	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	微博信息内容*/
@property (nonatomic, copy) NSString *text;

/**	object	微博作者的用户信息字段 详细*/
@property (nonatomic, strong) StatusUser *user;

/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;

/** 微博配图地址。多图时返回多图链接。无配图返回“[]” */
@property (nonatomic, strong) NSArray *pic_urls;
/**	int	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;



@end


@interface StatusUser : NSObject

/**	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;

/**	string	用户头像地址，50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;

/** 认证类型 */
@property (nonatomic, assign) XMUserVerifiedType verified_type;

@end



@interface PictureUrl : NSObject

@property (nonatomic, copy) NSString * thumbnail_pic;

@end
 
 
 
