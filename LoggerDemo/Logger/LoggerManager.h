//
//  LoggerManager.h
//  LoggerDemo
//
//  Created by user on 2020/8/3.
//  Copyright © 2020 Baotou BAOYIN Consumer Finance Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

/**
 *  日志级别
 */

#define LOGGER_INFO 1
#define LOGGER_WARN 2
#define LOGGER_ERROR 3


#define APP_LOG_INFO(logStr,...)  [LoggerManager systemLogWithLevel:LOGGER_INFO function:__func__ numLine:__LINE__ infoStr:logStr];
#define APP_LOG_WARN(logStr,...)  [LoggerManager systemLogWithLevel:LOGGER_WARN function:__func__ numLine:__LINE__ infoStr:logStr];
#define APP_LOG_ERROR(logStr,...) [LoggerManager systemLogWithLevel:LOGGER_ERROR function:__func__ numLine:__LINE__ infoStr:logStr];

NS_ASSUME_NONNULL_BEGIN

@interface LoggerManager : NSObject



/**
 *  初始化
 */
+ (instancetype)sharedInstance;

/**
 *  记录日志所在的函数名称
 *  @param level    日志级别，Info、Warn、Error
 *  @param function 函数名
 *  @param numLine  行数
 *  @param infoStr  日志内容
 */
+(void)systemLogWithLevel:(int)level function:(const char *)function numLine:(int)numLine infoStr:(NSString *)infoStr;


/**
 保存网络请求日志
 @param urlStr 请求地址
 @param requestStr 请求的数据
 @param responseStr 返回的数据
 */
+(void)networkLogWithURLStr:(NSString *)urlStr requestStr:(NSString *)requestStr responseStr:(NSString *)responseStr;

//存储系统日志路径
+(NSString *)getSystemLoggerArrayPath;


//存储网络请求日志路径
+(NSString *)getNetWorkLoggerArrayPath;
@end

NS_ASSUME_NONNULL_END
