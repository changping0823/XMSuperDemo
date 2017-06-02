//
//  XMMyViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2016/11/18.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "XMMyViewController.h"
#import "UITextField+Extension.h"


static NSString *const TestBURL = @"databank://";

@interface XMMyViewController ()
@property (nonatomic, strong) NSMutableArray *views;
@property(nonatomic, strong)UITextField *textField;

@end

@implementation XMMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField = [[UITextField alloc]init];
//    self.textField.showKeyboardTool = YES;
    self.textField.backgroundColor = [UIColor RandomColor];
    [self.view addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.center.mas_equalTo(self.view);
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.textField resignFirstResponder];
    [self.view endEditing:YES];
    
    NSURL *url = [NSURL URLWithString:TestBURL];
    BOOL result = [[UIApplication sharedApplication] canOpenURL:url];
    
//    if (result == YES) {
    
        [[UIApplication sharedApplication] openURL:url];
        
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
