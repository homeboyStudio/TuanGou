//
//  TGImageTool.h
//  点评团购
//
//  Created by homeboy on 14/11/29.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  下载图片的工具类
//  将SDWebImage与代码降低耦合

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TGImageTool : NSObject
+ (void)downloadImage:(NSString *)url placehoder:(UIImage *)place imageView:(UIImageView *)imageView;
+ (void)clear;
@end
