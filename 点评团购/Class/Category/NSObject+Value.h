//
//  NSObject+Value.h
//
//
//  Created by homeboy on 14-11-23.
//  Copyright (c) 2014年 homeboy. All rights reserved.
//  将数据转换成模型

#import <Foundation/Foundation.h>

@interface NSObject (Value)
// 设置数据
- (void)setValues:(NSDictionary *)values;
@end