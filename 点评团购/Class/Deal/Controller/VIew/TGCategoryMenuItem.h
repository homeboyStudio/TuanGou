//
//  TGCategoryMenuItem.h
//  点评团购
//
//  Created by homeboy on 14/11/24.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  分类菜单项 scroll按钮

#import "TGDealBOttomMenuItem.h"
@class TGCategory;
@interface TGCategoryMenuItem : TGDealBOttomMenuItem
//需要显示的分类
@property (nonatomic,strong)TGCategory *category;
@end
