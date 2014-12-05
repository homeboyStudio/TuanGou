//
//  TGMainController.m
//  点评团购
//
//  Created by homeboy on 14/11/20.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//


#import "TGMainController.h"
#import "TGDock.h"
#import "Comment.h"
#import "TGDealListController.h"
#import "TGMapController.h"
#import "TGCollectController.h"
#import "TGMineController.h"
#import "TGNavigationController.h"
@interface TGMainController ()<TGDockDelegate>
{
    UIView *_contentView;
}
@end

@implementation TGMainController

- (void)viewDidLoad {
    [super viewDidLoad];
   //1.添加Dock
    TGDock *dock = [[TGDock alloc]init];
    dock.delegate = self;
    [dock setFrame:CGRectMake(0, 0, 0, self.view.frame.size.height)];
    [self.view addSubview:dock];
    //添加内容  让_contentView上的控件随着一起自动伸缩
    CGFloat w = self.view.frame.size.width - kDockItemW;
    CGFloat h = self.view.frame.size.height;
    _contentView = [[UIView alloc]init];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _contentView.frame = CGRectMake(kDockItemW,0, w, h);
    [self.view addSubview:_contentView];
    //添加子控制器
    [self addAllChildControllers];
  }
#pragma mark - 点击了dock上的某个标签
- (void)dock:(TGDock *)dock tabChangeForm:(int)from to:(int)to
{
    //1.先移除旧的控制器
    UIViewController *old = self.childViewControllers[from];
    [old.view  removeFromSuperview];
    
    UIViewController *new = self.childViewControllers[to];
    new.view.frame = _contentView.bounds;
    new.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_contentView addSubview:new.view];
}
#pragma mark - 添加子控制器
- (void)addAllChildControllers
{
    TGDealListController *dealCtl = [[TGDealListController alloc]init];
    TGNavigationController *nav0 = [[TGNavigationController alloc]initWithRootViewController:dealCtl];
    [self addChildViewController:nav0];
    
    TGMapController *mapCtl = [[TGMapController alloc]init];
    TGNavigationController *nav1 = [[TGNavigationController alloc]initWithRootViewController:mapCtl];
    [self addChildViewController:nav1];
    
    TGCollectController *collectCtl = [[TGCollectController alloc]init];
    TGNavigationController *nav2 = [[TGNavigationController alloc]initWithRootViewController:collectCtl];
    [self addChildViewController:nav2];

    TGMineController *mineCtl = [[TGMineController alloc]init];
    TGNavigationController *nav3 = [[TGNavigationController alloc]initWithRootViewController:mineCtl];
    [self addChildViewController:nav3];
    
    //默认选中团购
    [self dock:nil tabChangeForm:0 to:0];
}
@end
