//
//  UIImage+HomeboyAdd.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-6.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "UIImage+HomeboyAdd.h"

@implementation UIImage (HomeboyAdd)

+ (UIImage *)resizedImage:(NSString *)imgNamge
{
    UIImage *image = [UIImage imageNamed:imgNamge];
 return  [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}
+ (UIImage *)resizedImage:(NSString *)imgNamge xPos:(CGFloat)x yPos:(CGFloat)y
{
    UIImage *image = [UIImage imageNamed:imgNamge];
    return  [image stretchableImageWithLeftCapWidth:image.size.width*x topCapHeight:image.size.height*y];
}
@end
