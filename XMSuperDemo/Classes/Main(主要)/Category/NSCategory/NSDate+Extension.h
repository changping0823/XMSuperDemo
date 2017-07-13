//
//  NSDate+Extension.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/6/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)


/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)xm_day;
- (NSUInteger)xm_month;
- (NSUInteger)xm_year;
- (NSUInteger)xm_hour;
- (NSUInteger)xm_minute;
- (NSUInteger)xm_second;
+ (NSUInteger)xm_day:(NSDate *)date;
+ (NSUInteger)xm_month:(NSDate *)date;
+ (NSUInteger)xm_year:(NSDate *)date;
+ (NSUInteger)xm_hour:(NSDate *)date;
+ (NSUInteger)xm_minute:(NSDate *)date;
+ (NSUInteger)xm_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)xm_daysInYear;
+ (NSUInteger)xm_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)xm_isLeapYear;
+ (BOOL)xm_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)xm_weekOfYear;
+ (NSUInteger)xm_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)xm_formatYMD;
+ (NSString *)xm_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)xm_weeksOfMonth;
+ (NSUInteger)xm_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)xm_begindayOfMonth;
+ (NSDate *)xm_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)xm_lastdayOfMonth;
+ (NSDate *)xm_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)xm_dateAfterDay:(NSUInteger)day;
+ (NSDate *)xm_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)xm_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)xm_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)xm_offsetYears:(int)numYears;
+ (NSDate *)xm_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)xm_offsetMonths:(int)numMonths;
+ (NSDate *)xm_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)xm_offsetDays:(int)numDays;
+ (NSDate *)xm_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)xm_offsetHours:(int)hours;
+ (NSDate *)xm_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)xm_daysAgo;
+ (NSUInteger)xm_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)xm_weekday;
+ (NSInteger)xm_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)xm_dayFromWeekday;
+ (NSString *)xm_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)xm_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)xm_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)xm_dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)xm_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)xm_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)xm_stringWithFormat:(NSString *)format;
+ (NSDate *)xm_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)xm_daysInMonth:(NSUInteger)month;
+ (NSUInteger)xm_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)xm_daysInMonth;
+ (NSUInteger)xm_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)xm_timeInfo;
+ (NSString *)xm_timeInfoWithDate:(NSDate *)date;
+ (NSString *)xm_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)xm_ymdFormat;
- (NSString *)xm_hmsFormat;
- (NSString *)xm_ymdHmsFormat;
+ (NSString *)xm_ymdFormat;
+ (NSString *)xm_hmsFormat;
+ (NSString *)xm_ymdHmsFormat;
@end
