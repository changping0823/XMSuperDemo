//
//  XMAddressBook.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/6/7.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMAddressBook.h"

@implementation XMAddressBook

-(NSString *)name{
    if (self.firstName == nil && self.lastName) {
        return self.lastName;
    }else if(self.lastName == nil && self.firstName){
        return self.firstName;
    }else{
        return [NSString stringWithFormat:@"%@%@",self.lastName,self.firstName];
    }
}

@end
