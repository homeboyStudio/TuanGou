//
//  TGCover.m
//  点评团购
//
//  Created by homeboy on 14/11/30.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGCover.h"
#define kAlpha 0.5
@implementation TGCover
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [ super initWithFrame:frame];
    if (self) {
        //1.背景色
        self.backgroundColor = [UIColor blackColor];
        //2.自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        //3.透明度
        self.alpha = kAlpha;
    }
    return self;
}
+ (id)cover;
{
    return [[self alloc]init];
}
//+ (id)coverWithTarget:(id)target action:(SEL)action
//{
//    TGCover *cover = [self cover];
//    [cover addGestureRecognizer:[UITapGestureRecognizer alloc]initWithTarget:target action:action];
//    
//    return cover;
//}
- (void)resetAlpha
{
    self.alpha = kAlpha;
}
@end
