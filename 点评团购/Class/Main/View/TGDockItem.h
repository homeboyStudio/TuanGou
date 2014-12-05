//
//  TGDockItem.h
//  点评团购
//
//  Created by homeboy on 14/11/21.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  首页父类控件按钮

#import <UIKit/UIKit.h>

@interface TGDockItem : UIButton
{
    UIImageView *_divider;
}
@property (nonatomic,copy)NSString *icon;   //普通图片
@property (nonatomic,copy)NSString *selectedIcon;  //选中图片
- (void)setIcon:(NSString *)icon selectedIco:(NSString *)selectedIcon;
@end
