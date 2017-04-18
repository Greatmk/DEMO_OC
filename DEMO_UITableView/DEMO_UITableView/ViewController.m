//
//  ViewController.m
//  DEMO_UITableView
//
//  Created by charles on 2017/4/18.
//  Copyright © 2017年 charles. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configData];
    [self configTableView];
}

/**
 构建数据,可以是本地数据,也可以是网络数据...
 */
-(void)configData{
    _dataArray = [NSMutableArray array];
    for (int i = 0; i<20; i++) {
        NSString *str = [NSString stringWithFormat:@"第%d行数据",i];
        [_dataArray addObject:str];
    }
}

-(void)configTableView{
    //style:UITableViewStylePlain和UITableViewStyleGrouped(可以分别尝试看看区别)
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];//创建对象
    _tableView.delegate = self;//遵循UITableViewDelegate
    _tableView.dataSource = self;//遵循UITableViewDataSource
    [_tableView setEditing:YES animated:YES];
    [self.view addSubview:_tableView];//添加到视图中
}

#pragma mark --UITableViewDelegate--

#pragma mark --UITableViewDataSource--

//tableview组数//默认可以不写,默认是1组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//tableview每组对应行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
//tableview的每一行
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";//静态的一个重用id
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];//根据id从缓存池中获取cell
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];//如果没有获取成功,则手动创建一个cell 重用id为敌营的id
    }
    cell.textLabel.text = _dataArray[indexPath.row];//系统cell默认的文本框.可以直接赋值,从数组中取出对应的行的数据
    return cell;//返回每行构建成功的cell
}

//组头部文字
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"header";//可以是唯一,也可以使用数组,根据section下标取出数组相应文字...
}
//组底部文字
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"footer";//可以是唯一,也可以使用数组,根据section下标取出数组相应文字...
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataArray removeObjectAtIndex:indexPath.row];
        [_tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [_dataArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    [_tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
