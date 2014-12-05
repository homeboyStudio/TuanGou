//
//  TGDealBottomMenu.h
//  点评团购
//
//  Created by homeboy on 14/11/24.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  底部菜单(父类)

#import <UIKit/UIKit.h>

@class TGSubtitlesView,TGDealBOttomMenuItem;
@interface TGDealBottomMenu : UIView
{
    UIScrollView *_scrollView;
    TGSubtitlesView *_subtitlesView;    //三级菜单所有子标题
    TGDealBOttomMenuItem *_selectedItem;   //底部菜单项按钮
}
@property (nonatomic,copy)void (^hideBlock)();

//- (void)settingSubtitlesView;
//通过动画显示自己
- (void)show;
- (void)hide;
@end
