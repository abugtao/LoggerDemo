//
//  AppDelegate+Logger.m
//  LoggerDemo
//
//  Created by user on 2020/8/3.
//  Copyright © 2020 Baotou BAOYIN Consumer Finance Co., Ltd. All rights reserved.
//

#import "AppDelegate+Logger.h"
#import "SystemLoggerViewController.h"
#import "NetWorkLoggerViewController.h"
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
@implementation AppDelegate (Logger)
-(void)initLoggerButton{
    UIButton *logButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0.2*[UIScreen mainScreen].bounds.size.height, 50, 50)];
    logButton.layer.cornerRadius = 25;
    logButton.layer.masksToBounds = YES;
    logButton.backgroundColor = UIColorFromRGBA(0xff8c26,0.7);
    [logButton setTitle:@"日志" forState:UIControlStateNormal];
    logButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.window addSubview:logButton];
    [logButton addTarget:self action:@selector(logAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    //添加拖动事件
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [logButton addGestureRecognizer:pan];
    
}
-(void)logAction{
    NetWorkLoggerViewController *networkLoggerVC = [[NetWorkLoggerViewController alloc] init];
    
    UIViewController *topVC = (UITabBarController *)self.window.rootViewController;
    
    if ([topVC isKindOfClass:[UITableViewController class]]) {
        UITabBarController *tabVC = (UITabBarController *)topVC;
        topVC = tabVC.selectedViewController;
    }
    
    if ([topVC isKindOfClass:[UINavigationController class]]){
        UINavigationController *navVC = (UINavigationController *)topVC;
        topVC = navVC.visibleViewController;
    }
    
    [topVC.navigationController pushViewController:networkLoggerVC animated:YES];
    
    

}
/**
 *  拖拽
 */
- (void)panAction:(UIGestureRecognizer *)gesture {

    UIView *btn = gesture.view;

    CGPoint point = [gesture locationInView:btn.superview];

    btn.center = point;

    if (gesture.state == UIGestureRecognizerStateChanged) {}

    if (gesture.state == UIGestureRecognizerStateEnded) {

        CGRect rect = btn.frame;
        rect.origin.x = 0;
        
        if (rect.origin.y > [UIScreen mainScreen].bounds.size.height-50) {
            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 50;
        }
        if (rect.origin.y < 0) {
            rect.origin.y = 0;
        }

        [UIView animateWithDuration:0.2 animations:^{
            btn.frame = rect;
        }];
    }
}

@end
