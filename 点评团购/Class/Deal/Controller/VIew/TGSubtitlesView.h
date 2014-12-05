//
//  TGSubtitlesView.h
//  点评团购
//
//  Created by homeboy on 14/11/25.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  所有子标题

#import <UIKit/UIKit.h>
@class TGSubtitlesView;
@protocol TGSubtitlesViewDelegate <NSObject>
@optional
- (void)subtitlesView:(TGSubtitlesView *)subtitlesView titleClick:(NSString *)title;
- (NSString *)subtitlesViewGetCurrentTitle:(TGSubtitlesView *)subtitlesView;
@end
@interface TGSubtitlesView : UIImageView
@property (nonatomic,strong)NSString *mainTitle;  //二级菜单的标题
@property (nonatomic,strong)NSArray *titles;   //所有子标题文字
@property (nonatomic,weak)id<TGSubtitlesViewDelegate>delegate;
//@property (nonatomic,copy)void (^setTitleBlock)(NSString *title);
//@property (noatomic,copy)NSString *(^getTitleBlock)();
//通过动画显示自己
- (void)show;
- (void)hide;
@end
