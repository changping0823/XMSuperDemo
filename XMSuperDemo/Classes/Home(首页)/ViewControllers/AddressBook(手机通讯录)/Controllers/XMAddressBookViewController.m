//
//  XMAddressBookViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/6/7.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMAddressBookViewController.h"
#import <AddressBook/AddressBook.h>
#import "XMAddressBook.h"

@interface XMAddressBookViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *addressBooks;

@end

@implementation XMAddressBookViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addressBookRequestAccess];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;

    

    if (![self hasAddressBookAuthorization]) {
        return;
    }
    
    // 2. 获取所有联系人
    ABAddressBookRef addressBookRef = ABAddressBookCreate();
    //获取所有联系人的数组
    CFArrayRef arrayRef = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    long count = CFArrayGetCount(arrayRef);
    
    for (int i = 0; i < count; i++) {
        //获取联系人对象的引用
        ABRecordRef people = CFArrayGetValueAtIndex(arrayRef, i);
        //获取当前联系人名字
        NSString *firstName = [self personInfo:people property:kABPersonFirstNameProperty];
        //获取当前联系人姓氏
        NSString *lastName = [self personInfo:people property:kABPersonLastNameProperty];
        //获取当前联系人的备注
        NSString * notes  = [self personInfo:people property:kABPersonNoteProperty];
        //获取当前联系人的名字前缀
        NSString* prefix = [self personInfo:people property:kABPersonPrefixProperty];
        //获取当前联系人的名字后缀
        NSString*suffix=[self personInfo:people property:kABPersonSuffixProperty];
        //获取当前联系人的昵称
        NSString*nickName=[self personInfo:people property:kABPersonNicknameProperty];
        //获取当前联系人的名字拼音
        NSString*firstNamePhoneic=[self personInfo:people property:kABPersonFirstNamePhoneticProperty];
        //获取当前联系人的姓氏拼音
        NSString*lastNamePhoneic=[self personInfo:people property:kABPersonLastNamePhoneticProperty];
        
        
        ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
        for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
            NSString * phoneNumber = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j));
            
            XMAddressBook * addressBook = [[XMAddressBook alloc]init];
            addressBook.phoneNumber = phoneNumber;
            addressBook.firstName   = firstName;
            addressBook.lastName    = lastName;
            addressBook.notes       = notes;
            addressBook.prefix = prefix;
            addressBook.suffix = suffix;
            addressBook.nickName = nickName;
            addressBook.firstNamePhoneic = firstNamePhoneic;
            addressBook.lastNamePhoneic = lastNamePhoneic;
            
            [self.addressBooks addObject:addressBook];
            
        }
       
    }
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.tableView reloadData];
    NSLog(@"phones=%@", self.addressBooks);
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        _tableView = tableView;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.addressBooks.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    XMAddressBook * adderssBook = self.addressBooks[indexPath.row];
    cell.textLabel.text = adderssBook.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



-(NSString *)personInfo:(ABRecordRef)record property:(ABPropertyID)property{
    return (__bridge NSString *)(ABRecordCopyValue(record, property));
}

-(void)addressBookCopyArrayOfAllPeople{
    
}


- (void)requestAuthorizationAddressBook {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)hasAddressBookAuthorization{
    // 判断是否授权
    
    // 1. 判读授权
    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    if (authorizationStatus != kABAuthorizationStatusAuthorized) {
        NSLog(@"没有授权");
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil
                                                            message:@"请在手机“设置-隐私-通讯录”中，允许俺搜助手访问您的通讯录"
                                                           delegate:nil
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
        
        [alertView show];
        
        return NO;
    }else{
        NSLog(@"可以访问通讯录");
        return YES;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self addressBookRequestAccess];
}

-(void)addressBookRequestAccess{
    ABAddressBookRef addressBookRef = ABAddressBookCreate();
    ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
        if (granted) { // 授权成功
            
        } else {  // 授权失败
            NSLog(@"授权失败！");
        }
    });
}


-(NSMutableArray *)addressBooks{
    if (!_addressBooks) {
        _addressBooks = [NSMutableArray array];
    }
    return _addressBooks;
}

@end
