//
//  XMCitySearchViewController.m
//  XMSuperDemo
//
//  Created by 任长平 on 2016/11/18.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "XMCitySearchViewController.h"

#import "XMProvince.h"

@interface XMCitySearchViewController ()<NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource>
/** 省 */
@property (nonatomic , strong) NSMutableArray *provinces;
/** 市 */
@property (nonatomic , strong) NSMutableArray *cities;
/** 县、区 */
@property (nonatomic , strong) NSMutableArray *districts;

@property (nonatomic , strong) UITableView *tableView;
@end

@implementation XMCitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString * provincesPath = [[NSString alloc]initWithString:[[NSBundle mainBundle]pathForResource:@"Provinces" ofType:@"xml"]];
    [self xm_XMLParserWithPath:provincesPath];
    
    NSString * citiesPath = [[NSString alloc]initWithString:[[NSBundle mainBundle]pathForResource:@"Cities" ofType:@"xml"]];
    [self xm_XMLParserWithPath:citiesPath];
    
    NSString * districtsPath = [[NSString alloc]initWithString:[[NSBundle mainBundle]pathForResource:@"Districts" ofType:@"xml"]];
    [self xm_XMLParserWithPath:districtsPath];

    
    [self.view addSubview:self.tableView];
    
}




- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        _tableView = tableView;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.provinces.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary * dict = self.provinces[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%@",dict[@"name"],dict[@"id"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}









-(void)xm_XMLParserWithPath:(NSString *)path{
    // 开始解析XML
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]];
    parser.delegate = self;
    [parser parse];

}


// 遇到一个开始标签的时候触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    
    if ([elementName isEqualToString:@"Province"]) {
        // 属性在attributeDict参数中传递过来，它是一个字典类型，其中的键的名字就是属性的名字，值是属性的值

        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:attributeDict[@"ID"] forKey:@"id"];
        [dict setObject:attributeDict[@"ProvinceName"] forKey:@"name"];
        [self.provinces addObject:dict];
        
    }else if ([elementName isEqualToString:@"City"]){

        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:[attributeDict objectForKey:@"ID"] forKey:@"id"];
        [dict setObject:[attributeDict objectForKey:@"CityName"] forKey:@"name"];
        [dict setObject:attributeDict[@"PID"] forKey:@"PID"];
        [dict setObject:attributeDict[@"ZipCode"] forKey:@"ZipCode"];
        [self.cities addObject:dict];
        
    }else if ([elementName isEqualToString:@"District"]){
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:[attributeDict objectForKey:@"ID"] forKey:@"id"];
        [dict setObject:[attributeDict objectForKey:@"DistrictName"] forKey:@"name"];
        [dict setObject:attributeDict[@"CID"] forKey:@"CID"];
        [self.districts addObject:dict];
    }
}



// 遇到文档结束时触发
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"_provinces == %@,cities == %@,districts == %@",self.provinces,self.cities,self.districts);
    
    [self.tableView reloadData];

}



-(NSMutableArray *)provinces{
    if (!_provinces) {
        _provinces = [NSMutableArray array];
    }
    return _provinces;
}
-(NSMutableArray *)cities{
    if (!_cities) {
        _cities = [NSMutableArray array];
    }
    return _cities;
}
-(NSMutableArray *)districts{
    if (!_districts) {
        _districts = [NSMutableArray array];
    }
    return _districts;
}

@end
