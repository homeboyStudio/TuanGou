//
//  TGBuyDock.h
//  点评团购
//
//  Created by homeboy on 14/11/30.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TGDeal,TGCenterLineLabel;
@interface TGBuyDock : UIView
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet TGCenterLineLabel *listPrice;
@property (nonatomic,strong)TGDeal *deal;   //团购模型
//返回从xib文件加载的dock
+ (id)buyDock;
@end
