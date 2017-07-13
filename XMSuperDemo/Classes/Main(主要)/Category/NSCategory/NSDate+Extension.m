//
//  NSDate+Extension.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/6/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSUInteger)xm_day {
    return [NSDate xm_day:self];
}

- (NSUInteger)xm_month {
    return [NSDate xm_month:self];
}

- (NSUInteger)xm_year {
    return [NSDate xm_year:self];
}

- (NSUInteger)xm_hour {
    return [NSDate xm_hour:self];
}

- (NSUInteger)xm_minute {
    return [NSDate xm_minute:self];
}

- (NSUInteger)xm_second {
    return [NSDate xm_second:self];
}

+ (NSUInteger)xm_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)xm_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)xm_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)xm_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)xm_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)xm_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)xm_daysInYear {
    return [NSDate xm_daysInYear:self];
}

+ (NSUInteger)xm_daysInYear:(NSDate *)date {
    return [self xm_isLeapYear:date] ? 366 : 365;
}

- (BOOL)xm_isLeapYear {
    return [NSDate xm_isLeapYear:self];
}

+ (BOOL)xm_isLeapYear:(NSDate *)date {
    NSUInteger year = [date xm_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)xm_formatYMD {
    return [NSDate xm_formatYMD:self];
}

+ (NSString *)xm_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",[date xm_year],[date xm_month], [date xm_day]];
}

- (NSUInteger)xm_weeksOfMonth {
    return [NSDate xm_weeksOfMonth:self];
}

+ (NSUInteger)xm_weeksOfMonth:(NSDate *)date {
    return [[date xm_lastdayOfMonth] xm_weekOfYear] - [[date xm_begindayOfMonth] xm_weekOfYear] + 1;
}

- (NSUInteger)xm_weekOfYear {
    return [NSDate xm_weekOfYear:self];
}

+ (NSUInteger)xm_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date xm_year];
    
    NSDate *lastdate = [date xm_lastdayOfMonth];
    
    for (i = 1;[[lastdate xm_dateAfterDay:-7 * i] xm_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)xm_dateAfterDay:(NSUInteger)day {
    return [NSDate xm_dateAfterDate:self day:day];
}

+ (NSDate *)xm_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)xm_dateAfterMonth:(NSUInteger)month {
    return [NSDate xm_dateAfterDate:self month:month];
}

+ (NSDate *)xm_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)xm_begindayOfMonth {
    return [NSDate xm_begindayOfMonth:self];
}

+ (NSDate *)xm_begindayOfMonth:(NSDate *)date {
    return [self xm_dateAfterDate:date day:-[date xm_day] + 1];
}

- (NSDate *)xm_lastdayOfMonth {
    return [NSDate xm_lastdayOfMonth:self];
}

+ (NSDate *)xm_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self xm_begindayOfMonth:date];
    return [[lastDate xm_dateAfterMonth:1] xm_dateAfterDay:-1];
}

- (NSUInteger)xm_daysAgo {
    return [NSDate xm_daysAgo:self];
}

+ (NSUInteger)xm_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)xm_weekday {
    return [NSDate xm_weekday:self];
}

+ (NSInteger)xm_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)xm_dayFromWeekday {
    return [NSDate xm_dayFromWeekday:self];
}

+ (NSString *)xm_dayFromWeekday:(NSDate *)date {
    switch([date xm_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)xm_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)xm_isToday {
    return [self xm_isSameDay:[NSDate date]];
}

- (NSDate *)xm_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

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
+ (NSString *)xm_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)xm_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date xm_stringWithFormat:format];
}

- (NSString *)xm_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)xm_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)xm_daysInMonth:(NSUInteger)month {
    return [NSDate xm_daysInMonth:self month:month];
}

+ (NSUInteger)xm_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date xm_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)xm_daysInMonth {
    return [NSDate xm_daysInMonth:self];
}

+ (NSUInteger)xm_daysInMonth:(NSDate *)date {
    return [self xm_daysInMonth:date month:[date xm_month]];
}

- (NSString *)xm_timeInfo {
    return [NSDate xm_timeInfoWithDate:self];
}

+ (NSString *)xm_timeInfoWithDate:(NSDate *)date {
    return [self xm_timeInfoWithDateString:[self xm_stringWithDate:date format:[self xm_ymdHmsFormat]]];
}

+ (NSString *)xm_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self xm_dateWithString:dateString format:[self xm_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate xm_month] - [date xm_month]);
    int year = (int)([curDate xm_year] - [date xm_year]);
    int day = (int)([curDate xm_day] - [date xm_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate xm_month] == 1 && [date xm_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self xm_daysInMonth:date month:[date xm_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate xm_day] + (totalDays - (int)[date xm_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate xm_month];
            int preMonth = (int)[date xm_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)xm_ymdFormat {
    return [NSDate xm_ymdFormat];
}

- (NSString *)xm_hmsFormat {
    return [NSDate xm_hmsFormat];
}

- (NSString *)xm_ymdHmsFormat {
    return [NSDate xm_ymdHmsFormat];
}

+ (NSString *)xm_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)xm_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)xm_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self xm_ymdFormat], [self xm_hmsFormat]];
}

- (NSDate *)xm_offsetYears:(int)numYears {
    return [NSDate xm_offsetYears:numYears fromDate:self];
}

+ (NSDate *)xm_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)xm_offsetMonths:(int)numMonths {
    return [NSDate xm_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)xm_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)xm_offsetDays:(int)numDays {
    return [NSDate xm_offsetDays:numDays fromDate:self];
}

+ (NSDate *)xm_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)xm_offsetHours:(int)hours {
    return [NSDate xm_offsetHours:hours fromDate:self];
}

+ (NSDate *)xm_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}
@end
