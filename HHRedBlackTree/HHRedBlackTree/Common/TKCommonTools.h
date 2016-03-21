//
//  TKCommonTools.h
//  ToolKit
//
//  Created by DoubleHH on 15/10/23.
//  Copyright © 2015年 chunhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define TKTemplateLabel(__font, __color)            [TKCommonTools templateLabelWithFont:(__font) color:(__color)]
#define TKTemplateLabel2(__font, __color, __text)   [TKCommonTools templateLabelWithFont:(__font) color:(__color) text:(__text)]
#define TKFormatFloat1(__doubleValue)               [TKCommonTools formatString1ValueWithDouble:(__doubleValue)]
#define TKFormatFloat2(__doubleValue)               [TKCommonTools formatString2ValueWithDouble:(__doubleValue)]
//! 当string为空或nil的时候，返回就是空字符串
#define TKFormatFloat2Str(__str)                    ((__str.length) ? TKFormatFloat2((__str).doubleValue) : @"")

// 分钟, 小时, 一天对应的秒数
FOUNDATION_EXPORT const int TKSecondsOfMinute;
FOUNDATION_EXPORT const int TKSecondsOfHour;
FOUNDATION_EXPORT const int TKSecondsOfDay;

// 中国日期形式, 如: 2014年3月20日 20:00
FOUNDATION_EXPORT NSString *const TKDateFormatChineseAll;
// 中国日期形式, 如: 2014-3-20 20:00
FOUNDATION_EXPORT NSString *const TKDateFormatChineseAll2;
// 中国日期形式, 如: 2014年3月20日
FOUNDATION_EXPORT NSString *const TKDateFormatChineseYMD;
// 中国日期形式, 如: 2014-3-20
FOUNDATION_EXPORT NSString *const TKDateFormatChineseShortYMD;
// 中国日期形式, 如: 3月20日 20:00
FOUNDATION_EXPORT NSString *const TKDateFormatChineseMDHM;
// 中国日期形式, 如: 3月20日
FOUNDATION_EXPORT NSString *const TKDateFormatChineseMD;
// 显示时分, 12:30
FOUNDATION_EXPORT NSString *const TKDateFormatHHMM;
// 显示英文的日期格式, 2014/12/03 16:30
FOUNDATION_EXPORT NSString *const TKDateFormatEnglishAll;
// 显示英文的日期格式, Oct 03, 2014 (2014/10/03)
FOUNDATION_EXPORT NSString *const TKDateFormatEnglishMedium1;
// 显示英文的日期格式, 12/03/2014
FOUNDATION_EXPORT NSString *const TKDateFormatEnglishMedium2;

void tk_safe_dispatch_sync_main_queue(void (^block)(void));

@interface TKCommonTools : NSObject

/**
 *  通过font和color生成一个label, 用于简化代码
 *
 *  @param font  字体
 *  @param color 颜色
 *
 *  @return label
 */
+ (UILabel *)templateLabelWithFont:(UIFont *)font color:(UIColor *)color;

/**
 *  通过font,color,text生成一个label, 用于简化代码
 *
 *  @param font  字体
 *  @param color 颜色
 *
 *  @return label
 */
+ (UILabel *)templateLabelWithFont:(UIFont *)font color:(UIColor *)color text:(NSString *)text;

/**
 *  生成一个可以拉伸的UIImage
 *
 *  @return 返回可以拉伸的UIImage
 */
+ (UIImage *)stretchableImageWithName:(NSString *)imageName;

/**
 *  格式化float型, 最多保留一位小数, 如果小数是0则抹掉
 */
+ (NSString *)formatString1ValueWithDouble:(double)floatValue;

/**
 *  格式化float型, 最多保留2位小数, 如果小数是0则抹掉
 */
+ (NSString *)formatString2ValueWithDouble:(double)floatValue;

/**
 *  dic to string
 */
+ (NSString *)stringWithDiconary:(NSDictionary *)dic;

/**
 *  string to dic
 */
+ (NSDictionary *)diconaryWithString:(NSString *)string;

/// 手机号的必须条件
+ (BOOL)isMobileAvailable:(NSString *)mobile;

/// 是否是邮箱格式
+ (BOOL)isValidateEmail:(NSString*)email;

@end

@interface TKCommonTools (TKDate)

/**
 *  根据格式化字符串格式化一个日期
 *
 *  @param format 格式化字符串
 *  @param date   NSDate
 *
 *  @return String
 */
+ (NSString *)dateStringWithFormat:(NSString *)format date:(NSDate *)date;

/**
 * @function    dateWithFormat
 * @abstract    按照指定的格式将字符串转换成日期对象
 * @param       format
 *              字符串日期的格式
 * @param       dateString
 *              日期字符串
 * @return      NSDate
 *              如果成功，返回日期对象，否则返回nil
 */
+ (NSDate *)dateWithFormat:(NSString *)format dateString:(NSString *)dateString;


/**
 *  根据date距离现在的时间生成一个时间字符串
 *
 *  @param date 要处理的时间对象
 *
 *  @return 日期字符串
 */
+(NSString *)dateDescFromNowWithDate:(NSDate *)date;

/**
 *  根据time距离现在的时间生成一个时间字符串
 *
 *  @param time 时间戳
 *
 *  @return 日期字符串
 */
+ (NSString *)dateDescFromNowWithTime:(double)time;

@end

