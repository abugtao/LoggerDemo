//
//  FirstViewController.m
//  LoggerDemo
//
//  Created by user on 2020/8/3.
//  Copyright © 2020 Baotou BAOYIN Consumer Finance Co., Ltd. All rights reserved.
//

#import "FirstViewController.h"
#import "LoggerManager.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *sandboxpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSLog(@"%@",sandboxpath);
    
    
//    NSArray *array = @[@"1",@"2",@"3"];
//
//    [array writeToFile:[LoggerManager getSystemLogArrayPath] atomically:YES];
    
//    [LoggerManager systemLogWithLevel:LOGGER_ERROR function:__func__ numLine:__LINE__ infoStr:@"aa",@"bb",@"cc",@"/Users/user/Library/Developer/CoreSimulator/Devices/2C3936EC-6DDF-4074-81EB-AEEADFBE406E/data/Containers/Data/Application/0CC9ABE6-4959-4D65-96C2-1A5DE852818A/Documents",nil];
    
//    APP_LOG_ERROR(@"haaha");
//    APP_LOG_INFO(@"bb",nil);
    
    [LoggerManager networkLogWithURLStr:@"/login" requestStr:[NSString stringWithFormat:@"%@",@{@"name":@"zht",@"psd":@"111"}] responseStr:[NSString stringWithFormat:@"%@",@{@"statusInfo":@{@"code":@"0000",@"message":@"ok"}}]];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonAciton) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)buttonAciton{
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:NULL];
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
