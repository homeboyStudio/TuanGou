//
//  NSString+FixScale.h
//  点评团购
//
//  Created by homeboy on 14/11/30.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FixScale)
// 生成一个保留fractionCount位小数的字符串(裁剪尾部多余的0)
+ (NSString *)stringWithDouble:(double)value fractionCount:(int)fractionCount;
@end
