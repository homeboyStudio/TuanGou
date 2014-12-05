//
//  TGCategory.h
//  点评团购
//
//  Created by homeboy on 14/11/24.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  代表分类对象

#import "TGBaseModel.h"

@interface TGCategory : TGBaseModel
@property (nonatomic,copy)NSString *icon;           //
@property (nonatomic,strong)NSArray *subcategories; //
@end
