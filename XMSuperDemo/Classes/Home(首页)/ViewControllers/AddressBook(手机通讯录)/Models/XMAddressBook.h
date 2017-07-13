//
//  XMAddressBook.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/6/7.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMAddressBook : NSObject


/** 名 */
@property(nonatomic, copy)NSString *firstName;
/** 姓 */
@property(nonatomic, copy)NSString *lastName;
@property(nonatomic, copy)NSString *name;

@property(nonatomic, copy)NSString *phoneNumber;
@property(nonatomic, copy)NSString *notes;

//获取当前联系人的名字前缀
@property(nonatomic, copy)NSString* prefix;
//获取当前联系人的名字后缀
@property(nonatomic, copy)NSString*suffix;
//获取当前联系人的昵称
@property(nonatomic, copy)NSString*nickName;
//获取当前联系人的名字拼音
@property(nonatomic, copy)NSString*firstNamePhoneic;
//获取当前联系人的姓氏拼音
@property(nonatomic, copy)NSString*lastNamePhoneic;

@end
