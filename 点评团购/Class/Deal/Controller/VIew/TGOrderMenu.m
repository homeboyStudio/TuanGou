//
//  TGOrderMenu.m
//  点评团购
//
//  Created by homeboy on 14/11/25.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGOrderMenu.h"
#import "TGMetaDataTool.h"
#import "TGOrderMenuItem.h"
#import "TGOrder.h"
#import "Comment.h"
@implementation TGOrderMenu
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [ super initWithFrame:frame];
    if (self) {
       //1.
        NSArray *orders = [TGMetaDataTool sharedTGMetaDataTool].totalOrders;
        int count = orders.count;
        for (int i = 0; i < count; i++) {
            TGOrder *order  = orders[i];
            TGOrderMenuItem *item = [[TGOrderMenuItem alloc]init];
            item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
            item.order = order;
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:item];
            //默认选中第0个Item
            if (i == 0) {
                item.selected = YES;
                _selectedItem = item;
            }
        }
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    }
    return self;
}
@end
