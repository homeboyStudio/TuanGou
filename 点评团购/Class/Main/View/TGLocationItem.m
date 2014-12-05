//
//  TGLocationItem.m
//  点评团购
//
//  Created by homeboy on 14/11/21.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGLocationItem.h"
#import "TGCityListController.h"
#import "Comment.h"
#import "TGMetaDataTool.h"
#import "City.h"
#import "TGLocationTool.h"
#define kImageScale 0.5
@interface TGLocationItem()<UIPopoverControllerDelegate>
{
    UIPopoverController *_popover;
    UIActivityIndicatorView *_indicator;
}
@end
@implementation TGLocationItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.设置内部的图片
//        [self setIcon:@"ic_district.png" selectedIco:@"ic_district_hl.png"];
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        //2.设置默认的文字
        [self setTitle:@"定位" forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        //3.设置图片的属性
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //4.监听点击
        [self addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchDown];
        //5.监听通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
        //6.定位城市
        [self loadCityData];
    }
    return self;
}
#pragma mark - 定位城市
- (void) loadCityData
{
   //1.添加圈圈
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    CGFloat x = kDockItemW * 0.5;
    CGFloat y = 25;
    indicator.center  = CGPointMake(x, y);
    [self addSubview:indicator];
    [indicator startAnimating];
    _indicator = indicator;
       //2.
    [TGLocationTool sharedTGLocationTool];
    
}
#pragma mark - 城市改变
- (void)cityChange
{
    City *city = [TGMetaDataTool sharedTGMetaDataTool].currentCity;
    //更改显示的城市名
    [self setTitle:city.name forState:UIControlStateNormal];
    //关闭popoverView
    [_popover dismissPopoverAnimated:YES];
    //显示
    self.enabled = YES;
    //移除圈圈
    [_indicator removeFromSuperview];
    _indicator = nil;
        //设置图标
     [self setIcon:@"ic_district.png" selectedIco:@"ic_district_hl.png"];
}
-(void)locationClick
{
    self.enabled = NO;
    TGCityListController *city = [[TGCityListController alloc] init];
    UIPopoverController *popover = [[UIPopoverController alloc]initWithContentViewController:city];
    //设置popover的bounds
    popover.popoverContentSize  = CGSizeMake(320, 480);
    _popover = popover;
    _popover.delegate = self;
    //self.bounds self
    //self.frame self.superview
    [_popover presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}
#pragma mark - popoverDelegate
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.enabled = YES;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height *kImageScale;
    return CGRectMake(0, 0, w, h);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * (1 - kImageScale);
    CGFloat y = contentRect.size.height - h;
    return CGRectMake(0,y , w, h);
}
@end
