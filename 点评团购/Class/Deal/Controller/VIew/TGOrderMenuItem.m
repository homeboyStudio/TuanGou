//
//  TGOrderMenuItem.m
//  点评团购
//
//  Created by homeboy on 14/11/25.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGOrderMenuItem.h"
#import "TGOrder.h"
@implementation TGOrderMenuItem
- (void)setOrder:(TGOrder *)order
{
    _order = order;
    [self setTitle:order.name forState:UIControlStateNormal];
}
@end
