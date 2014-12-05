//
//  TGCenterLineLabel.m
//  点评团购
//
//  Created by homeboy on 14/11/30.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGCenterLineLabel.h"

@implementation TGCenterLineLabel

- (void)drawRect:(CGRect)rect
{
    //任何显示都是画上去的一定要调用super方法初
    [super drawRect:rect];
 //1.先获得上下文
   CGContextRef context = UIGraphicsGetCurrentContext();
    //2.
    [self.textColor setStroke];
    
    //3.画线
    CGContextMoveToPoint(context, 0, rect.size.height/3);
//    CGFloat endX = [self.text sizeWithFont:self.font].width;
   CGFloat endX  = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
    CGContextAddLineToPoint(context, endX, rect.size.height/3);
    //4.渲染
    CGContextStrokePath(context);
}
@end
