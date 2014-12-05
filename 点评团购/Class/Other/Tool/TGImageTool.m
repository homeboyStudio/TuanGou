//
//  TGImageTool.m
//  点评团购
//
//  Created by homeboy on 14/11/29.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGImageTool.h"
#import "UIImageView+WebCache.h"
@implementation TGImageTool
+ (void)downloadImage:(NSString *)url placehoder:(UIImage *)place imageView:(UIImageView *)imageView
{
    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}
+ (void)clear
{
    //清除内存中的缓存图片
    [[SDImageCache sharedImageCache] clearMemory];
    //取消所有的下载请求
    [[SDWebImageManager sharedManager] cancelAll];
}
@end
