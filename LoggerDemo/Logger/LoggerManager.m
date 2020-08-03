//
//  LoggerManager.m
//  LoggerDemo
//
//  Created by user on 2020/8/3.
//  Copyright © 2020 Baotou BAOYIN Consumer Finance Co., Ltd. All rights reserved.
//

#import "LoggerManager.h"
#define SYSTEM_LOG_ARRAY_MAX_COUNT 500
#define NETWORK_LOG_ARRAY_MAX_COUNT 100

@interface LoggerManager()

//系统日志（最多300）
@property(nonatomic,strong)NSMutableArray *systemLogArray;

//网络请求日志（最多100）
@property(nonatomic,strong)NSMutableArray *networkLogArray;


@end

@implementation LoggerManager

/**
 *  初始化
 */
+ (instancetype)sharedInstance
{
    static LoggerManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}

/**
 *  记录日志所在的函数名称
 *  @param level    日志级别，Info、Warn、Error
 *  @param function 函数名
 *  @param numLine  行数
 *  @param infoStr  日志内容
 */
+(void)systemLogWithLevel:(int)level function:(const char *)function numLine:(int)numLine infoStr:(NSString *)infoStr{
    
    if (!infoStr) {
        return;
    }
//    NSMutableString *printStr = [NSMutableString stringWithFormat:@"%@",infoStr];
//    va_list argsList;
//    id otherObjc;
//    va_start(argsList, infoStr);
//    while ((otherObjc = va_arg(argsList, id))) {
//        [printStr appendFormat:@"%@",otherObjc];
//    }
//    va_end(argsList);
    
    
    NSString *levelStr;
    switch (level) {
        case LOGGER_INFO:
            levelStr = @"INFO";
            break;
        case LOGGER_WARN:
            levelStr = @"WARN";
            break;
        case LOGGER_ERROR:
            levelStr = @"ERROR";
            break;
            
        default:
            break;
    }
    
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [format stringFromDate:[NSDate date]];
    
    
    NSString *loggerStr = [NSString stringWithFormat:@"[%@]-[%@]-%@  %@行  打印内容： %@",levelStr,dateStr,[NSString stringWithUTF8String: function],[NSString stringWithFormat:@"%d",numLine],infoStr];
    
    
    
    
    @synchronized (self) {
        CGFloat height = [LoggerManager textSizeByLabel:loggerStr labelWidth:[[UIScreen mainScreen] bounds].size.width - 40 font:[UIFont systemFontOfSize:12]];
        
        NSDictionary *logDic = @{
                                 @"loggerStr":loggerStr,
                                 @"cellHeight":[NSNumber numberWithFloat: height + 40]
                                 };
        
        while ([LoggerManager sharedInstance].systemLogArray.count >= SYSTEM_LOG_ARRAY_MAX_COUNT) {
            [[LoggerManager sharedInstance].systemLogArray removeLastObject];
        }
        [[LoggerManager sharedInstance].systemLogArray insertObject:logDic atIndex:0];
        [[LoggerManager sharedInstance].systemLogArray writeToFile:[LoggerManager getSystemLoggerArrayPath] atomically:YES];
        
    }
    
}

/**
 保存网络请求日志
 @param urlStr 请求地址
 @param requestStr 请求的数据
 @param responseStr 返回的数据
 */
+(void)networkLogWithURLStr:(NSString *)urlStr requestStr:(NSString *)requestStr responseStr:(NSString *)responseStr{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [format stringFromDate:[NSDate date]];
    
    NSString *loggerStr = [NSString stringWithFormat:@"请求地址:%@\n请求时间:%@\n请求内容:%@\n返回内容:%@",urlStr,dateStr,requestStr,responseStr];
    @synchronized (self) {
        CGFloat height = [LoggerManager textSizeByLabel:loggerStr labelWidth:[[UIScreen mainScreen] bounds].size.width - 40 font:[UIFont systemFontOfSize:12]];
        
        NSDictionary *logDic = @{
                                 @"loggerStr":loggerStr,
                                 @"cellHeight":[NSNumber numberWithFloat: height + 40]
                                 };
        
        while ([LoggerManager sharedInstance].networkLogArray.count >= NETWORK_LOG_ARRAY_MAX_COUNT) {
            [[LoggerManager sharedInstance].networkLogArray removeLastObject];
        }
        [[LoggerManager sharedInstance].networkLogArray insertObject:logDic atIndex:0];
        [[LoggerManager sharedInstance].networkLogArray writeToFile:[LoggerManager getNetWorkLoggerArrayPath] atomically:YES];
        
    }
}

//获取系统日志缓存数据
+(NSArray *)getSystemLoggerDataArray{
    return [NSArray arrayWithContentsOfFile:[self getSystemLoggerArrayPath]];
}

//存储系统日志路径
+(NSString *)getSystemLoggerArrayPath{
    NSString *documentpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *plistPath = [documentpath stringByAppendingPathComponent:@"SystemLoggerArray.plist"];
    return plistPath;
    
    
}

//获取网络请求日志缓存数据
+(NSArray *)getNetWorkLoggerDataArray{
    return [NSArray arrayWithContentsOfFile:[self getNetWorkLoggerArrayPath]];
}

//存储网络请求日志路径
+(NSString *)getNetWorkLoggerArrayPath{
    NSString *documentpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *plistPath = [documentpath stringByAppendingPathComponent:@"NetWorkLoggerArray.plist"];
    return plistPath;

}


//获取loggerstr所在高度
+ (CGFloat)textSizeByLabel:(NSString *)text labelWidth:(CGFloat)labelWidth font:(UIFont *)font
{
    return [text boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
}

#pragma mark -getter
-(NSMutableArray *)systemLogArray{
    if (!_systemLogArray) {
        NSArray *array = [LoggerManager getSystemLoggerDataArray];
        _systemLogArray = [NSMutableArray arrayWithArray:array];
    }
    return _systemLogArray;
}

-(NSMutableArray *)networkLogArray{
    if (!_networkLogArray) {
        NSArray *array = [LoggerManager getNetWorkLoggerDataArray];
        _networkLogArray = [NSMutableArray arrayWithArray:array];
    }
    return _networkLogArray;
}


@end
