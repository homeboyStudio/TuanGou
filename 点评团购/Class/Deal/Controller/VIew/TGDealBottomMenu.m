 //
//  TGDealBottomMenu.m
//  点评团购
//
//  Created by homeboy on 14/11/24.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "Comment.h"
#import "TGMetaDataTool.h"
#import "TGDealBottomMenu.h"
#import "TGDealBOttomMenuItem.h"
#import "TGOrderMenuItem.h"
#import "TGDistrictMenuItem.h"
#import "TGCategoryMenuItem.h"
#import "TGSubtitlesView.h"
#import "TGCover.h"
@protocol TGSubtitlesViewDelegate;
@interface TGDealBottomMenu()<TGSubtitlesViewDelegate>
{
    UIView *_cover;                     //蒙版
    UIView *_contentView;               // 内容视图用来容纳scroll和子标题
    
    

}
@end
@implementation TGDealBottomMenu
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        // 1.添加蒙板（遮盖）
        UIView *cover = [[UIView alloc] init];
        cover.alpha = 0.4;
        cover.frame = self.bounds;
        cover.autoresizingMask = self.autoresizingMask;
        cover.backgroundColor = [UIColor blackColor];
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
        [self addSubview:cover];
        _cover = cover;
        
        // 2.内容view
        _contentView = [[UIView alloc] init];
        _contentView.frame = CGRectMake(0, 64, self.frame.size.width, kBottomMenuItemH);
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_contentView];
        
        // 3.添加UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, kBottomMenuItemH);
        scrollView.backgroundColor = [UIColor whiteColor];
        [_contentView addSubview:scrollView];
        _scrollView = scrollView;
    }
    return self;
}
#pragma mark 监听二级item的点击
- (void)itemClick:(TGDealBOttomMenuItem *)item
{
    // 1.控制item的状态
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    // 2.查看是否有子分类     调用子类的方法
    if (item.titles.count) { // 显示所有的子标题
        [self showSubTitlesView:item];
       } else { // 隐藏所有的子标题
           [self hideSubtitlesView:item];
    }
}
#pragma mark - 显示子标题
- (void)showSubTitlesView:(TGDealBOttomMenuItem *)item
{
    //动画执行
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kDefaultAnimDuration];
    if (_subtitlesView == nil) {
        _subtitlesView = [[TGSubtitlesView alloc] init];
        _subtitlesView.delegate = self;
//        [self settingSubtitlesView];
    }
    _subtitlesView.frame = CGRectMake(0, kBottomMenuItemH, self.frame.size.width,_subtitlesView.frame.size.height);
    //设置子标题的主标题（二级标题）
    _subtitlesView.mainTitle = [item titleForState:UIControlStateNormal];
    _subtitlesView.titles = item.titles;
    //当前子标题没有正在展示的时候，就需要执行动画
    if (_subtitlesView.superview == nil) { // 没有父控件
        [_subtitlesView show];
    }
    [_contentView insertSubview:_subtitlesView belowSubview:_scrollView];
    //调整整个内容View的高度
    CGRect f = _contentView.frame;
    f.size.height = kBottomMenuItemH + _subtitlesView.frame.size.height;
    _contentView.frame = f;
    [UIView commitAnimations];
}
#pragma mark - 隐藏子标题
- (void)hideSubtitlesView:(TGDealBOttomMenuItem *)item
{
    //通过动画隐藏子标题
    [_subtitlesView hide];
    //调整整个contentView的高度
    CGRect f = _contentView.frame;
    f.size.height = kBottomMenuItemH;
    _contentView.frame = f;
    //设置当前数据
    NSString *title = [item titleForState:UIControlStateNormal];
    if ([item isKindOfClass:[TGCategoryMenuItem class]]) {
        [TGMetaDataTool sharedTGMetaDataTool].currentCategory = title;
    }else if([item isKindOfClass:[TGDistrictMenuItem class]]){
        [TGMetaDataTool sharedTGMetaDataTool].currentDistricy = title;
         }else{
             [TGMetaDataTool sharedTGMetaDataTool].currentOrder = [[TGMetaDataTool sharedTGMetaDataTool] orderWithName:title];
         }
}
- (void)show
{
    _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
    _contentView.alpha = 0;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        //1.scrollView从上面 - 》 下面
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        //2.蒙版（0 - 0.4）
        _cover.alpha = 0.4;
    }];
}
- (void)hide
{
    
    if (_hideBlock) {
        _hideBlock();
    }
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
       //1.scrollView从下面 - 》 上面
        _contentView.transform = CGAffineTransformMakeTranslation(0,-_contentView.frame.size.height);
        _contentView.alpha = 0.0;
       //2.蒙版（0.4 - 0.0）
        _cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        //恢复属性
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        _cover.alpha = 0.4;
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
