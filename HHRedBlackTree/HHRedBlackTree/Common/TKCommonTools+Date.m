//
//  TKCommonTools+Date.m
//  ToolKit
//
//  Created by DoubleHH on 15/10/23.
//  Copyright © 2015年 chunhui. All rights reserved.
//

#import "TKCommonTools.h"

const int TKSecondsOfMinute = 60;
const int TKSecondsOfHour   = 3600;
const int TKSecondsOfDay    = 86400;

// 中国日期形式, 如: 2014年3月20日 20:00
NSString *const TKDateFormatChineseAll          = @"yyyy年MM月dd日 HH:mm";
// 中国日期形式, 如: 2014-3-20 20:00
NSString *const TKDateFormatChineseAll2         = @"yyyy-MM-dd HH:mm";
// 中国日期形式, 如: 2014年3月20日
NSString *const TKDateFormatChineseYMD          = @"yyyy年MM月dd日";
// 中国日期形式, 如: 2014-3-20
NSString *const TKDateFormatChineseShortYMD     = @"yyyy-MM-dd";
// 中国日期形式, 如: 3月20日 20:00
NSString *const TKDateFormatChineseMDHM         = @"MM月dd日 HH:mm";
// 中国日期形式, 如: 3月20日
NSString *const TKDateFormatChineseMD           = @"MM月dd日";
// 显示时分, 12:30
NSString *const TKDateFormatHHMM                = @"HH:mm";
// 显示英文的日期格式, 2014/12/03 16:30
NSString *const TKDateFormatEnglishAll          = @"yyyy/MM/dd HH:mm";
// 显示英文的日期格式, Oct 03, 2014 (2014/10/03)
NSString *const TKDateFormatEnglishMedium1      = @"MMM dd, YYYY";
// 显示英文的日期格式, 12/03/2014
NSString *const TKDateFormatEnglishMedium2      = @"MM/dd/YYYY";

@implementation TKCommonTools (TKDate)

+ (NSDateFormatter *)sharedformater {
    static NSDateFormatter *sFormater;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sFormater = [[NSDateFormatter alloc] init];
    });
    return sFormater;
}

+ (NSString *)dateStringWithFormat:(NSString *)format date:(NSDate *)date {
    if (!format.length || !date) {
        return nil;
    }
    NSDateFormatter *formatter = [self sharedformater];
    NSString *str = nil;
    @synchronized (formatter) {
        [formatter setDateFormat:format];
        str = [formatter stringFromDate:date];
    }
    return str;
}

+ (NSDate *)dateWithFormat:(NSString *)format dateString:(NSString *)dateString {
    if (format.length == 0 || dateString.length == 0) {
        return nil;
    }
    NSDate *date = nil;
    NSDateFormatter *formatter = [self sharedformater];
    @synchronized (formatter) {
        formatter.dateFormat = format;
        date = [formatter dateFromString:dateString];
    }
    return date;
}

+ (NSString *)dateFormateForDate:(NSDate *)date hasShort:(BOOL)hasShort
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *component = [calender components: (NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    NSDate *now = [NSDate date];
    NSDateComponents *nowComponents = [calender components:(NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay)  fromDate:now];
    
    if (hasShort) {
        if (nowComponents.year == component.year &&
            nowComponents.month == component.month &&
            nowComponents.day == component.day) {
            return [NSString stringWithFormat:@"%02ld:%02ld", (long)component.hour, (long)component.minute];
        }
    }
    return [NSString stringWithFormat:@"%04ld年%02ld月%02ld日", (long)component.year, (long)component.month, (long)component.day];
}

+ (NSString *)dateDescFromNowWithDate:(NSDate *)date {
    NSDate *now = [NSDate date];
    NSTimeInterval interval = [now timeIntervalSinceDate:date];
    NSString *des = nil;
    
    if (interval < 300) {
        des = @"刚刚";
    }else if (interval < 3600){
        des = [NSString stringWithFormat:@"%d分钟前",(int)interval/60];;
    }else if (interval < 86400){
        des = [NSString stringWithFormat:@"%d小时前",(int)(interval/3600)];
    }else if (interval < 2592000 /*86400 * 30*/) {
        des = [NSString stringWithFormat:@"%d天前",(int)(interval/86400)];
    } else if (interval < 31536000 /*86400 * 365*/) {
        des = [NSString stringWithFormat:@"%d月前",(int)(interval/2592000)];
    } else {
        des = [NSString stringWithFormat:@"%d年前",(int)(interval/31536000)];
    }
    return des;
}

+ (NSString *)dateDescFromNowWithTime:(double)time {
    return [self dateDescFromNowWithDate:[NSDate dateWithTimeIntervalSince1970:time]];
}

@end

