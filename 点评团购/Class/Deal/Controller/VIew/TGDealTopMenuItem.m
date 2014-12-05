//
//  TGDealTopMenuItem.m
//  点评团购
//
//  Created by homeboy on 14/11/24.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGDealTopMenuItem.h"
#import "Comment.h"
#import "UIImage+HomeboyAdd.h"
#define kScale 0.85
@implementation TGDealTopMenuItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        //设置箭头
        [self setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
        //设置内容为居中而是填充
        self.imageView.contentMode = UIViewContentModeCenter;
//        //右侧分割线
        UIImage *img = [UIImage imageNamed:@"separator_topbar_item.png"];
        UIImageView *divider = [[UIImageView alloc]initWithImage:img];
        divider.center = CGPointMake(kTopMenuItemW , kTopMenuItemH *0.5);
        divider.bounds = CGRectMake(0, 0, 1, kTopMenuItemH * 0.6);
        [self addSubview:divider];
        //选中时的背景
        [self setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_normal.png"] forState:UIControlStateSelected];
    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}
- (void)setFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x,0,kTopMenuItemW, kTopMenuItemH);
    [super setFrame:frame];
}
#pragma mark - 改变内部文字，图片位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width * kScale, contentRect.size.height);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width * kScale, 0, contentRect.size.width * (1 - kScale), contentRect.size.height);

}
@end
