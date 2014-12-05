//
//  NSString+png.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-7.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "NSString+png.h"

@implementation NSString (png)
-(NSString *)fileAppend:(NSString *)append
{
    //获得文件的扩展名
    NSString *ext = [self pathExtension];
    NSString *imgName = [self stringByDeletingPathExtension];
    imgName = [[imgName stringByAppendingFormat:@"%@",append] stringByAppendingPathExtension:ext];
            return imgName;

}
@end
