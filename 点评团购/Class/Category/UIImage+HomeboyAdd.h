//
//  UIImage+HomeboyAdd.h
//  新浪微博9.5
//
//  Created by homeboy on 14-9-6.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  自由拉伸图片

#import <UIKit/UIKit.h>

@interface UIImage (HomeboyAdd)

#pragma mark - 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgNamge;

+ (UIImage *)resizedImage:(NSString *)imgNamge xPos:(CGFloat)x yPos:(CGFloat)y;
@end
