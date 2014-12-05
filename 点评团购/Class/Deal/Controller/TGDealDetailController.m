//
//  TGDealDetailController.m
//  点评团购
//
//  Created by homeboy on 14/11/30.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//
#import "Comment.h"
#import "UIBarButtonItem+WB.h"
#import "TGDealDetailController.h"
#import "TGDeal.h"
#import "TGBuyDock.h"
#import "TGDetailDock.h"

#import "TGDealInfoController.h"
#import "TGDealWebController.h"
#import "TGMerchantController.h"
@interface TGDealDetailController()<TGDetailDockDelegate>
{
    TGDetailDock *_detailDock;
}
@end
@implementation TGDealDetailController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //1.基本设置
    [self baseSetting];
    //2.添加顶部的购买栏
    [self addBuyDock];
    //3.添加右边的选项卡
     [self addDetailDock];
    //4.初始化子控制器
    [self addAllChildControllers];
}
#pragma mark - 基本设置
- (void)baseSetting
{
    //1.背景色
    self.view.backgroundColor = kGlobalBg;
    //2.设置
    self.title = _deal.title;
    //设置barButtonItem
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithIcon:@"btn_share.png" highlightedIcon:@"btn_share_pressed.png" tagert:nil action:nil],[[UIBarButtonItem alloc]initWithIcon:@"ic_deal_collect.png" highlightedIcon:@"ic_deal_collect_pressed.png" tagert:nil action:nil]];
    
  }
#pragma mark - 添加顶部的购买栏
- (void)addBuyDock
{
    TGBuyDock *dock = [TGBuyDock buyDock];
    dock.deal = _deal;
    dock.frame = CGRectMake(0, 64, self.view.frame.size.width, 60);
    [self.view addSubview:dock];
}
#pragma mark - 添加右边的选项卡
- (void)addDetailDock
{
    TGDetailDock *dock = [TGDetailDock detailDock];
    CGSize size = dock.frame.size;
    CGFloat x = self.view.frame.size.width - size.width;
    CGFloat y = self.view.frame.size.height - size.height - 100;
    dock.frame = CGRectMake(x, y, 0, 0);
    dock.delegate = self;
    [self.view addSubview:dock];
    _detailDock = dock;
}
#pragma mark - 初始化子控制器
- (void)addAllChildControllers
{   //1.团购详情
    TGDealInfoController *info = [[TGDealInfoController alloc]init];
    info.deal = _deal;
    [self addChildViewController:info];
    //默认选中第0个控制器
    [self detailDock:nil btnClickFrom:0 to:0];
    //2.图文详情
    TGDealWebController *web = [[TGDealWebController alloc]init];
    web.deal = _deal;
    [self addChildViewController:web];
    //3.商家详情
    TGMerchantController *merchant = [[TGMerchantController alloc]init];
    [self addChildViewController:merchant];

   }
#pragma marl - 详细dock的代理方法
- (void)detailDock:(TGDetailDock *)detailDock btnClickFrom:(int)from to:(int)to
{
    //1.移除旧的控制器的view
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    UIViewController *new = self.childViewControllers[to];
    new.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth ;
    CGFloat w = self.view.frame.size.width - _detailDock.frame.size.width;
    CGFloat h =  self.view.frame.size.height;
    new.view.frame = CGRectMake(0,0, w,h);
    [self.view insertSubview:new.view atIndex:0];
}
@end
