//
//  TGMetaDataTool.h
//  点评团购
//
//  Created by homeboy on 14/11/23.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  ****元数据管理类****
//城市数据
//下属分区数据
//分类数据
#import <Foundation/Foundation.h>
#import "Singleton.h"

@class City,TGOrder;
@interface TGMetaDataTool : NSObject
singleton_interface(TGMetaDataTool)
@property (nonatomic, strong, readonly) NSDictionary *totalCities; // 所有的城市
@property (nonatomic, strong, readonly) NSArray *totalCitySections; // 所有的城市组数据


@property (nonatomic,strong,readonly)NSArray *totalCategories;   //所有分类数据

@property (nonatomic,strong,readonly)NSArray *totalOrders;   //所有分类数据

- (TGOrder *)orderWithName:(NSString *)name;

- (NSString *)iconWithCategoryName:(NSString *)name;

@property (nonatomic, strong)City *currentCity;        // 当前选中的城市
@property (nonatomic,strong)NSString *currentCategory; //当前选中的类别
@property (nonatomic,strong)NSString *currentDistricy; //当前选中的区域
@property (nonatomic,strong)TGOrder *currentOrder;     //当前选中的排序
@end
