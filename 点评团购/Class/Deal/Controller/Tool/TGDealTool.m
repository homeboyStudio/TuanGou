//
//  TGDealTool.m
//  点评团购
//
//  Created by homeboy on 14/11/29.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGDealTool.h"
#import "DPAPI.h"
#import "TGMetaDataTool.h"
#import "City.h"
#import "TGOrder.h"
#import "TGDeal.h"
#import "NSObject+Value.h"
#import "Comment.h"
#import "TGLocationTool.h"
#import <CoreLocation/CoreLocation.h>
typedef void(^RequeastBlock) (id result,NSError *errorObj);
@interface TGDealTool()<DPRequestDelegate>
{
    NSMutableDictionary *_blocks;
}
@end
@implementation TGDealTool
singleton_implementation(TGDealTool)

- (instancetype)init
{
    if (self = [super init]) {
        //初始化存储block的字典
        _blocks = [NSMutableDictionary dictionary];
    }
    return self;
}
#pragma mark -  获得周边的团购  //返回周边团购信息
- (void)dealsWithPosition:(CLLocationCoordinate2D)pos success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{
    City *city = [TGLocationTool sharedTGLocationTool].locationCity;
    if (city == nil) return;
    CGFloat  latitude = pos.latitude;
    CGFloat longitude = pos.longitude;
    [self requestWithURL:@"v1/deal/find_deals" params:@{@"city":city.name,
    @"latitude":@(latitude),@"longitude":@(longitude),@"radius":@5000
    } block:^(id result, NSError *errorObj) {
                        if (errorObj) {
                             if (error) {
                                        error(errorObj);
                                        }
                             }else if(success){    //请求成功
                        NSArray *array = result[@"deals"]; 
                        NSMutableArray *deals = [NSMutableArray array];
                        for (NSDictionary *dic in array) {
                            TGDeal *deal = [[TGDeal alloc]init];
                            [deal setValues:dic];
                            [deals addObject:deal];
                                                        }
                    success(deals,[result[@"total_count"] intValue]);
                         }

    }];
}
#pragma mark - 获得指定的团购数据
- (void)dealsWithID:(NSString *)ID success:(DealSuccessBlock)success error:(DealErrorBlock)error
{
    [self requestWithURL:@"v1/deal/get_single_deal" params:@{ @"deal_id":ID }
                   block:^(id result, NSError *errorObj) {
                if (result) {
                        if (success) {  //调用bolck一定要判断是否有数
                            TGDeal *deal = [[TGDeal alloc]init];
                            [deal setValues:result[@"deals"][0]];
                            success(deal);
                                    }
                            }else{
                                if (errorObj) {
                                    if(error){
                                    error(errorObj);
                                    }
                                   }
                            } 
      }];
}
#pragma mark - 获得第page页的团购数据
- (void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(20) forKey:@"limit"];
    //1.*****添加城市参数*******
    NSString *city = [TGMetaDataTool sharedTGMetaDataTool].currentCity.name;
    [params setObject:city forKey:@"city"];
    //2.添加区域参数
    NSString *district = [TGMetaDataTool sharedTGMetaDataTool].currentDistricy;
    if (district && ![district isEqualToString:kAllDistrict]) {
        [params setObject:district forKey:@"region"];
    }
    //3.添加分类参数
    NSString *category = [TGMetaDataTool sharedTGMetaDataTool].currentCategory;
    if (category && ![category isEqualToString:kAllCategory]) {
        [params setObject:category forKey:@"category"];
    }
    //4.添加排序按钮
    TGOrder *order = [TGMetaDataTool sharedTGMetaDataTool].currentOrder;
    if (order) {
        [params setObject:@(order.index) forKey:@"sort"];
        City *city = [TGLocationTool sharedTGLocationTool].locationCity;
        if(order.index == 7 && city){  //按距离最近排序
            [params setObject:@(city.position.latitude) forKey:@"latitude"];
            [params setObject:@(city.position.longitude) forKey:@"longitude"];
        }
    }
   //********添加页码参数******
    [params setObject:@(page) forKey:@"page"];
    //5.发送请求
    [self requestWithURL:@"v1/deal/find_deals" params:params block:^(id result, NSError *errorObj) {  //请求失败
        if (errorObj) {
            if (error) {
                error(errorObj);
            }
        }else if(success){    //请求成功
            NSArray *array = result[@"deals"];
            NSMutableArray *deals = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                TGDeal *deal = [[TGDeal alloc]init];
                [deal setValues:dic];
                [deals addObject:deal];
            }
            success(deals,[result[@"total_count"] intValue]);
            }
    }];
}
#pragma mark - 封装了大众点评的任何请求
- (void)requestWithURL:(NSString *)url params:(NSDictionary *)params block:(RequeastBlock)block
{
    DPAPI *api = [DPAPI sharedDPAPI];
   DPRequest *request = [api requestWithURL:url params:params delegate:self];
    
    //一次请求对应字典里面的一次block回调
    [_blocks setObject:block forKey:request.description];
}
#pragma mark - 大众点评代理方法
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //取出字典当中对应请求的的block
    RequeastBlock block = _blocks[request.description];
    if (block) {
        block(result,nil);
    }
  }
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    RequeastBlock block = _blocks[request.description];
    if (block) {
        block(nil,error);
    }

}
@end
