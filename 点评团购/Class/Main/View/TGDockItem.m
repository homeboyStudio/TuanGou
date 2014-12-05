//
//  TGDockItem.m
//  点评团购
//
//  Created by homeboy on 14/11/21.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
// Dock

#import "TGDockItem.h"
#import "Comment.h"
@implementation TGDockItem
//初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *diver = [[UIImageView alloc]init];
        diver.frame = CGRectMake(0, 0, kDockItemW, 3);
        diver.image = [UIImage imageNamed:@"separator_tabbar_item.png"];
        [self addSubview:diver];
        _divider = diver;
    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kDockItemW,kDockItemH);
    [super setFrame:frame];
}
- (void)setIcon:(NSString *)icon selectedIco:(NSString *)selectedIcon
{
    self.icon = icon;
    self.selectedIcon = selectedIcon;
}
- (void)setIcon:(NSString *)icon
{
    [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}
- (void)setSelectedIcon:(NSString *)selectedIcon
{
    [self setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateDisabled];
}
//没用高亮状态
- (void)setHighlighted:(BOOL)highlighted {}
@end
