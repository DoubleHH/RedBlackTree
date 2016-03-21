//
//  HHImageUtil.h
//  HHRedBlackTree
//
//  Created by DoubleH on 16/3/21.
//  Copyright © 2016年 DoubleH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HHImageWithColor(_color, _size)                 [HHImageUtil imageWithColor:(_color) size:(_size)]
#define HHRadiusImageWithColor(_color, _size, _radius)  [HHImageUtil imageWithColor:(_color) size:(_size) radius:(_radius)]

@import UIKit;

@interface HHImageUtil : NSObject

+ (UIImage *)roundImage:(UIImage *)image;

+ (UIImage *)normImageOrientation:(UIImage *)image;

+ (UIImage *)resizeImage:(UIImage *)image maxWidth:(NSInteger)width;

+ (UIImage *)snapShotForView:(UIView *)view;

+ (UIImage *)subImageFor:(UIImage *)image inRegion:(CGRect)region;

+ (UIImage *)rotateImage:(UIImage *)image numberHalfPi:(NSInteger)num;

/*
 * image 获取二进制 数据
 * maxSize : 最大字节数 (bytes)
 *
 */
+ (NSData *)resizeImage:(UIImage *)image maxSize:(NSInteger)maxSize;

+ (void)saveToPhotosWithImage:(UIImage *)image;

+ (UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size radius:(float)radius;

@end
