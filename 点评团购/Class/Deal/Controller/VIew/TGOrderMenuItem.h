//
//  TGOrderMenuItem.h
//  点评团购
//
//  Created by homeboy on 14/11/25.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGDealBOttomMenuItem.h"
@class TGOrder;
@interface TGOrderMenuItem : TGDealBOttomMenuItem
@property (nonatomic,strong)TGOrder *order;
@end
