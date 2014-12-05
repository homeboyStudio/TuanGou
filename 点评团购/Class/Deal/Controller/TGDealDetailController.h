//
//  TGDealDetailController.h
//  点评团购
//
//  Created by homeboy on 14/11/30.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  团购列表详细控制器

#import <UIKit/UIKit.h>
@class TGDeal;
@interface TGDealDetailController : UIViewController
@property (nonatomic,strong)TGDeal *deal;  //一个团购模型
@end
