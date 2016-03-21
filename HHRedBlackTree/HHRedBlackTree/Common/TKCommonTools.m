//
//  TKCommonTools.m
//  ToolKit
//
//  Created by DoubleHH on 15/10/23.
//  Copyright © 2015年 chunhui. All rights reserved.
//

#import "TKCommonTools.h"

inline void tk_safe_dispatch_sync_main_queue(void (^block)(void)) {
    if (!block) return;
    if ([[NSThread currentThread] isMainThread]) return block();
    dispatch_sync(dispatch_get_main_queue(), ^{ block(); });
}

@implementation TKCommonTools

+ (UILabel *)templateLabelWithFont:(UIFont *)font color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

+ (UILabel *)templateLabelWithFont:(UIFont *)font color:(UIColor *)color text:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    [label sizeToFit];
    return label;
}

+ (UIImage *)stretchableImageWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    if (image) {
        return [image stretchableImageWithLeftCapWidth:ceil(image.size.width * .5) topCapHeight:ceil(image.size.height * .5)];
    }
    return nil;
}

+ (NSString *)formatString1ValueWithDouble:(double)doubleValue {
    NSString *str = [NSString stringWithFormat:@"%.1f", doubleValue];
    if ([str hasSuffix:@".0"]) {
        str = [NSString stringWithFormat:@"%.0f", doubleValue];
    }
    return str;
}

+ (NSString *)formatString2ValueWithDouble:(double)doubleValue {
    NSString *str = [NSString stringWithFormat:@"%.2f", doubleValue];
    if ([str hasSuffix:@"0"]) {
        str = [NSString stringWithFormat:@"%.1f", doubleValue];
    } else {
        return str;
    }
    if ([str hasSuffix:@".0"]) {
        str = [NSString stringWithFormat:@"%.0f", doubleValue];
    }
    return str;
}

+ (NSString *)stringWithDiconary:(NSDictionary *)dic {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0
                                                         error:nil];
    if (!jsonData) {
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)diconaryWithString:(NSString *)string {
    if (!string.length) {
        return nil;
    }
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (!jsonData) {
        return nil;
    }
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    return json;
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL) isMobileAvailable:(NSString *)mobile {
    //手机号以1开头，八个 \d 数字字符
    // NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^1[0-9]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)isValidateEmail:(NSString*)email {
    NSString * regex = @"^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:email];
    return isMatch;
}

@end
