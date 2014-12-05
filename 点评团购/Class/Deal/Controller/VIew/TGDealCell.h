//
//  TGDealCell.h
//  点评团购
//
//  Created by homeboy on 14/11/29.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TGDeal;
@interface TGDealCell : UICollectionViewCell
//描述
@property (nonatomic,weak)IBOutlet UILabel *desc;
//图片
@property (nonatomic,weak)IBOutlet UIImageView *image;
//价格
@property (nonatomic,weak)IBOutlet UILabel *price;
//购买人数
@property (nonatomic,weak)IBOutlet UIButton *purchaseCount;
//标签
@property (nonatomic,weak)IBOutlet UIImageView *badge;
//团购模型
@property (nonatomic,strong)TGDeal *deal;
@end
