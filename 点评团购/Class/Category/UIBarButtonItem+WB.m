//
//  UIBarButtonItem+WB.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-14.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "UIBarButtonItem+WB.h"

@implementation UIBarButtonItem (WB)
- (id)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted tagert:(id)tagert action:(SEL)action
{
    //创建按钮
    UIButton *btn  = [[UIButton alloc]init];
    UIImage *image = [UIImage imageNamed:icon];
    //设置普通状态下的图片
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    //设置尺寸
    btn.bounds = (CGRect){CGPointZero,image.size};
    [btn addTarget:tagert  action:action forControlEvents:UIControlEventTouchUpInside];

    return [self initWithCustomView:btn];
}
@end
