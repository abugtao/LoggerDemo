//
//  SystemLoggerViewController.m
//  LoggerDemo
//
//  Created by user on 2020/8/3.
//  Copyright © 2020 Baotou BAOYIN Consumer Finance Co., Ltd. All rights reserved.
//

#import "SystemLoggerViewController.h"
#import "LoggerManager.h"
#define LOGGER_DEBUG_INFO  UIColorWithRGB(32,201,72)
#define LOGGER_DEBUG_WRAN  UIColorWithRGB(255,179,0)
#define LOGGER_DEBUG_ERROR UIColorWithRGB(255,0,0)
#define UIColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
@interface SystemLoggerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation SystemLoggerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
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
    if ([loggerStr hasPrefix:@"[INFO]"]) {
        cell.textLabel.textColor = LOGGER_DEBUG_INFO;
    }
    if ([loggerStr hasPrefix:@"[WARN]"]) {
        cell.textLabel.textColor = LOGGER_DEBUG_WRAN;
    }
    if ([loggerStr hasPrefix:@"[ERROR]"]) {
        cell.textLabel.textColor = LOGGER_DEBUG_ERROR;
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    NSNumber *num = [dic objectForKey:@"cellHeight"];
    return [num floatValue];
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithContentsOfFile:[LoggerManager getSystemLoggerArrayPath]];
    }
    return _dataArray;
}

@end
