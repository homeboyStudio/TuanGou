//
//  TGDealTool.h
//  点评团购
//
//  Created by homeboy on 14/11/29.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  团购请求工具类

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <MapKit/MapKit.h>
@class TGDeal;
//deals装得都是模型数据
typedef void (^DealsSuccessBlock)(NSArray *deals,int totalConut);
typedef void (^DealsErrorBlock)(NSError *error);

//获得一个指定的团购详细数据模型
typedef void (^DealSuccessBlock)(TGDeal *deal);
typedef void (^DealErrorBlock)(NSError *error);

@interface TGDealTool : NSObject
singleton_interface(TGDealTool)

#pragma mark - 获得第page页的团购数据
- (void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;
#pragma mark - 获得指定的团购数据
- (void)dealsWithID:(NSString *)ID success:(DealSuccessBlock)success error:(DealErrorBlock)error;
#pragma mark - 获得周边的团购信息
- (void)dealsWithPosition:(CLLocationCoordinate2D)pos success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;

@end
