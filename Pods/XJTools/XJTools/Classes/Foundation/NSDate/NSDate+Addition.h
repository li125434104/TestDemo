//
//  NSDate+Addition.h
//  XJTools_Example
//
//  Created by taishu on 2019/4/26.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Addition)

/**
 NSDate转字符串

 @param date 输入的date
 @param dataFormat 日期格式
 @return 返回的字符串
 
 */
+ (NSString *)stringFromDate:(NSDate *)date setDateFormat:(nullable NSString *)dataFormat;


/**
 字符串转NSDate

 @param dateString 输入的字符串
 @param dataFormat 日期格式
 @return 返回的NSDate
 */
+ (NSDate *)dateFromString:(NSString *)dateString setDateFormat:(nullable NSString *)dataFormat;

/**
 获取当前时间的字符串

 @param format 日期格式
 @return 返回的字符串
 */
+ (NSString *)currentDateWithFormat:(NSString *)format;


/**
 获取当前时间的时间戳

 @return 返回的字符串
 */
+ (NSString *)currentTimestamp;

/**
 字符串转时间戳

 @param formatTime 输入的字符串
 @param dataFormat 日期格式
 @return 返回的时间戳
 */
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime setDateFormat:(NSString *)dataFormat;

/**
 时间戳转字符串

 @param timestamp 输入的时间戳
 @param dataFormat 日期格式
 @return 返回的时间字符串
 */
+ (NSString *)timestampToString:(NSInteger)timestamp setDateFormat:(NSString *)dataFormat;

/**
 获取两个时间戳的时间差
 
 @param timestamp 时间戳
 @param anotherTimestamp 另一个时间戳
 @return 返回的时间差
 */
+ (NSInteger)differenceOfTimestamp:(NSInteger)timestamp anotherTimestamp:(NSInteger)anotherTimestamp;

/**
 获取某个时间距离当前时间的描述

 @param lastTime 时间NSDate
 @return 返回的描述
 */
+ (NSString *)timeIntervalFromLastTime:(NSDate *)lastTime;

#pragma mark ---- 从当前日期相对日期时间
///明天
+ (NSDate *)dateTomorrow;
///昨天
+ (NSDate *)dateYesterday;
///今天后几天
+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;
///今天前几天
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;
///当前小时后dHours个小时
+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours;
///当前小时前dHours个小时
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours;
///当前分钟后dMinutes个分钟
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes;
///当前分钟前dMinutes个分钟
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes;

- (NSDate *)dateByAddingDays: (NSInteger) dDays;
- (NSDate *)dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *)dateByAddingHours: (NSInteger) dHours;
- (NSDate *)dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *)dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *)dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *)dateByAddingMonths:(NSInteger)dMonths;
- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths;

#pragma mark ---- Comparing dates 比较时间
///比较年月日是否相等
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
///是否是今天
- (BOOL)isToday;
///是否是明天
- (BOOL)isTomorrow;
///是否是昨天
- (BOOL)isYesterday;

///是否是同一周
- (BOOL)isSameWeekAsDate:(NSDate *)aDate;
///是否是本周
- (BOOL)isThisWeek;
///是否是本周的下周
- (BOOL)isNextWeek;
///是否是本周的上周
- (BOOL)isLastWeek;

///是否是同一月
- (BOOL)isSameMonthAsDate:(NSDate *)aDate;
///是否是本月
- (BOOL)isThisMonth;
///是否是本月的下月
- (BOOL)isNextMonth;
///是否是本月的上月
- (BOOL)isLastMonth;

///是否是同一年
- (BOOL)isSameYearAsDate:(NSDate *)aDate;
///是否是今年
- (BOOL)isThisYear;
///是否是今年的下一年
- (BOOL)isNextYear;
///是否是今年的上一年
- (BOOL)isLastYear;

///是否提前aDate
- (BOOL)isEarlierThanDate:(NSDate *)aDate;
///是否晚于aDate
- (BOOL)isLaterThanDate:(NSDate *)aDate;
///是否晚是未来
- (BOOL)isInFuture;
///是否晚是过去
- (BOOL)isInPast;


///是否是工作日
- (BOOL)isTypicallyWorkday;
///是否是周末
- (BOOL)isTypicallyWeekend;

#pragma mark -- Another
/**
 * 获取指定月份的天数
 */
- (NSUInteger)daysInMonth:(NSUInteger)month;
+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)isLeapYear;
+ (BOOL)isLeapYear:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
