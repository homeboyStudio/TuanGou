//
//  TGDock.m
//  点评团购
//
//  Created by homeboy on 14/11/20.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//
#import "TGDock.h"
#import "Comment.h"
#import "TGMoreItem.h"
#import "TGLocationItem.h"
#import "TGTabItem.h"
@interface TGDock()
{
    //被选中的标签
    TGTabItem *_selectedItem;
}
@end
@implementation TGDock
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.自动伸缩(高度+右边)
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        //设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tabbar.png"]];
        //2.添加logo 
        [self addLog];
        //添加选项标签
        [self addTabs];
        //添加定位
        [self addLocation];
        //添加更多
        [self addMore];
    }
    return self;
}
#pragma maek - logo
- (void)addLog
{
    UIImageView *logo = [[UIImageView alloc]init];
    logo.image =[UIImage imageNamed:@"ic_logo.png"];
    //设置尺寸
    CGFloat scale = 0.6;
    CGFloat w = logo.image.size.width *scale;
    CGFloat h = logo.image.size.height *scale;
    logo.bounds =CGRectMake(0, 0 , w, h);
    logo.center = CGPointMake(kDockItemW * 0.5, kDockItemH *0.5);
    [self addSubview:logo];
}
#pragma mark - 重写setter方法，内定自己的宽度
- (void)setFrame:(CGRect)frame
{
    frame.size.width = kDockItemW;
    [super setFrame:frame];
}
#pragma mark - 添加选项标签
- (void)addTabs
{
    [self addOneTab:@"ic_deal.png" selectedIcon:@"ic_deal_hl.png" index:1];
    [self addOneTab:@"ic_map.png" selectedIcon:@"ic_map_hl.png" index:2];
    [self addOneTab:@"ic_collect.png" selectedIcon:@"ic_collect_hl.png" index:3];
    [self addOneTab:@"ic_mine.png" selectedIcon:@"ic_mine_hl.png" index:4];
    //添加底部的分割线
    UIImageView *diver = [[UIImageView alloc]init];
    diver.frame = CGRectMake(0, kDockItemH * 5, kDockItemW, 3);
    diver.image = [UIImage imageNamed:@"separator_tabbar_item.png"];
    [self addSubview:diver];
}
- (void)addOneTab:(NSString *)icon selectedIcon:(NSString *)selectedIcon index:(NSInteger)index
{
    TGTabItem *tab = [[TGTabItem alloc]init];
    tab.frame = CGRectMake(0, kDockItemH * index, 0, 0);
    [tab setIcon:icon selectedIco:selectedIcon];
    tab.tag = index - 1;
    [self addSubview:tab];
    [tab addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchDown];
    if (index == 1) {
        [self tabClick:tab];
    }
}
#pragma mark - 监听点击事件
- (void)tabClick:(TGTabItem *)tab
{
    //通知代理   防止）selectedItem的tag值被tab给覆盖，所以放上
    if ([_delegate respondsToSelector:@selector(dock:tabChangeForm:to:)]) {
        [_delegate dock:self tabChangeForm:_selectedItem.tag to:tab.tag];
    }
    _selectedItem.enabled = YES;
    
    tab.enabled = NO;
    
    _selectedItem = tab;
}
#pragma mark - location
- (void)addLocation{
    TGLocationItem *location = [[TGLocationItem alloc]init];
    CGFloat y = self.frame.size.height - kDockItemH*2;
    location.frame =CGRectMake(0, y, 0, 0);
    [self addSubview:location];
}
#pragma mark - maore
- (void)addMore
{
    TGMoreItem  *btn = [[TGMoreItem alloc]init];
    btn.frame = CGRectMake(0, self.frame.size.height - kDockItemH, 0,0);
      [self addSubview:btn];
}
@end
