//
//  TGDealBOttomMenuItem.m
//  点评团购
//
//  Created by homeboy on 14/11/25.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGDealBOttomMenuItem.h"
#import "Comment.h"
#import "UIImage+HomeboyAdd.h"
@implementation TGDealBOttomMenuItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [ super initWithFrame:frame];
    if (self) {
        //1.右边的分割线
        UIImage *img = [UIImage imageNamed:@"separator_filter_item.png"];
        UIImageView *divider = [[UIImageView alloc]initWithImage:img];
        divider.center = CGPointMake(kBottomMenuItemW , kBottomMenuItemH *0.5);
        divider.bounds = CGRectMake(0, 0, 1, kBottomMenuItemH * 0.7);
        [self addSubview:divider];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        //背景图片
        [self setBackgroundImage:[UIImage resizedImage:@"bg_filter_toggle_hl.png"] forState:UIControlStateSelected];
    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kBottomMenuItemW, kBottomMenuItemH);
    [super setFrame:frame];
}
- (void)setHighlighted:(BOOL)highlighted{}
- (NSArray *)titles
{
    return nil; 
}
@end
