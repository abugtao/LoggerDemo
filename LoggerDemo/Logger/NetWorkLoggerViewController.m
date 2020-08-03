//
//  NetWorkLoggerViewController.m
//  LoggerDemo
//
//  Created by user on 2020/8/3.
//  Copyright © 2020 Baotou BAOYIN Consumer Finance Co., Ltd. All rights reserved.
//

#import "NetWorkLoggerViewController.h"
#import "LoggerManager.h"
#import "SystemLoggerViewController.h"
@interface NetWorkLoggerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation NetWorkLoggerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIButton *rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItemButton.frame = CGRectMake(0, 0, 100, 40);
    [rightItemButton setTitle:@"系统日志" forState:UIControlStateNormal];
    rightItemButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightItemButton sizeToFit];

    [rightItemButton addTarget:self action:@selector(navRightBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)navRightBtnOnClick{
    SystemLoggerViewController *systemLoggerVC = [[SystemLoggerViewController alloc] init];
    [self.navigationController pushViewController:systemLoggerVC animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    NSString *loggerStr = [dic objectForKey:@"loggerStr"];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = loggerStr;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    NSNumber *num = [dic objectForKey:@"cellHeight"];
    return [num floatValue];
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithContentsOfFile:[LoggerManager getNetWorkLoggerArrayPath]];
    }
    return _dataArray;
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
