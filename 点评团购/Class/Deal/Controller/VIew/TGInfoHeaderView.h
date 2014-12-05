//
//  TGInfoHeaderView.h
//  点评团购
//
//  Created by homeboy on 14/12/1.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  详细信息页面头部控件

#import <UIKit/UIKit.h>
@class  TGDeal;
@interface TGInfoHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIButton *anyTimeBack;
@property (weak, nonatomic) IBOutlet UIButton *expireBack;
@property (weak, nonatomic) IBOutlet UIButton *time;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;

@property (nonatomic,strong)TGDeal *deal;
+ (id)infoHeaderView;
@end
