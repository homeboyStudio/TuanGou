//
//  TGMetaDataTool.m
//  点评团购
//
//  Created by homeboy on 14/11/23.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGMetaDataTool.h"
#import "CitySection.h"
#import "City.h"
#import "NSObject+Value.h"
#import "TGCategory.h"
#import "TGOrder.h"
#import "Comment.h"
#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"visitedCityNames.data"]
@interface TGMetaDataTool()
{
    NSMutableArray *_visitedCityNames; // 存储曾经访问过城市的名称
    
    NSMutableDictionary *_totalCities; // 存放所有的城市 key 是城市名  value 是城市对象
    
    CitySection *_visitedSection; // 最近访问的城市组数组
}
@end

@implementation TGMetaDataTool
singleton_implementation(TGMetaDataTool)

- (id)init
{
    if (self = [super init]) {
        // 初始化项目中的所有元数据
        [self loadCityData];
        //添加分类数据
        [self loadCategoryData];
        //初始化排序数据
        [self loadOrderData];
  
        }
    return self;
}
#pragma mark - 非常重要的数据加载！！！
- (void)loadCityData
{
    // 存放所有的城市
    _totalCities = [NSMutableDictionary dictionary];
    // 存放所有的城市组
    NSMutableArray *tempSections = [NSMutableArray array];
    
    // 1.添加热门城市组
    CitySection *hotSection = [[CitySection alloc] init];
    hotSection.name = @"热门城市";
    hotSection.cities = [NSMutableArray array];
    [tempSections addObject:hotSection];                 //1
    
    // 2.添加A-Z组
    // 加载plist数据
    NSArray *azArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cities.plist" ofType:nil]];
    for (NSDictionary *azDict in azArray) {
        // 创建城市组
        CitySection *section = [[CitySection alloc] init];
        [section setValues:azDict];
        [tempSections addObject:section];
        
        // 遍历这组的所有城市
        for (City *city in section.cities) {
            if (city.hot) { // 添加热门城市
                [hotSection.cities addObject:city];
            }
            //字典存储了所有城市，key是城市名
            [_totalCities setObject:city forKey:city.name];
        }
    }
    
    // 3.从沙盒中读取之前访问过的城市名称
    _visitedCityNames = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (_visitedCityNames == nil) {
        _visitedCityNames = [NSMutableArray array];
    }
    
    // 4.添加最近访问城市组
    CitySection *visitedSection = [[CitySection alloc] init];
    visitedSection.name = @"最近访问";
    visitedSection.cities = [NSMutableArray array];
    [tempSections insertObject:visitedSection atIndex:0];
    _visitedSection = visitedSection;
    
    for (NSString *name in _visitedCityNames) {
        City *city = _totalCities[name];
        [visitedSection.cities addObject:city];
    }
    
    _totalCitySections = tempSections;

}
#pragma mark - 初始化分类数据
- (void)loadCategoryData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Categories.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *temp = [NSMutableArray array];
    //添加全部的分类
    TGCategory *all = [[TGCategory alloc]init];
    all.name = kAllCategory;
    all.icon = @"ic_filter_category_-1.png";
       [temp addObject:all];
    for (NSDictionary *dic in array) {
        TGCategory *c = [[TGCategory alloc]init];
        [c setValues:dic];
        [temp addObject:c];
    }
    _totalCategories = temp;
}
#pragma mark -  初始化排序数据
- (void)loadOrderData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Orders.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *temp = [NSMutableArray array];
    int count = array.count;
    for (int i = 0; i < count; i++) {
        TGOrder *order = [[TGOrder alloc]init];
        order.name = array[i];
        order.index = i + 1;
        [temp addObject:order];
    }
    _totalOrders = temp;
}
- (TGOrder *)orderWithName:(NSString *)name
{
    for ( TGOrder *order in _totalOrders) {
        if ([name isEqualToString:order.name]) {
            return order;
        }
    }
    return nil;
}
#pragma mark - 将最近访问的城市添加到
- (void)setCurrentCity:(City *)currentCity
{
    _currentCity = currentCity;
    
    // 1.移除之前的城市名   将沙盒中相同的名字删除
    [_visitedCityNames removeObject:currentCity.name];
    
    // 2.将新的城市名放到最前面
    [_visitedCityNames insertObject:currentCity.name atIndex:0];
    
    // 3.将新的城市放到_visitedSection的最前面
    [_visitedSection.cities removeObject:currentCity];
    [_visitedSection.cities insertObject:currentCity atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_visitedCityNames toFile:kFilePath];

    //4.修改当前选中的区域,在发出修改城市同之前，将区域名显示为全部商区
    _currentDistricy = kAllDistrict;
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCityChangeNote object:nil];
//    MyLog(@"%@",kFilePath);
}
- (void)setCurrentCategory:(NSString *)currentCategory
{
    _currentCategory = currentCategory;
      [[NSNotificationCenter defaultCenter] postNotificationName:kCategoryChangeNote object:nil];
}
- (void)setCurrentDistricy:(NSString *)currentDistricy
{
    _currentDistricy = currentDistricy;
      [[NSNotificationCenter defaultCenter] postNotificationName:kDistrictChangeNote object:nil];
}
- (void)setCurrentOrder:(TGOrder *)currentOrder
{
    _currentOrder = currentOrder;
      [[NSNotificationCenter defaultCenter] postNotificationName:kOrderChangeNote object:nil];
}
#pragma mark - 通过分类名称取得图标
- (NSString *)iconWithCategoryName:(NSString *)name
{
    for (TGCategory *c  in _totalCategories) {
        //1.分类名称一致
        if ([c.name isEqualToString:name] ) return c.icon;
        //2.有这个子分类
        if ([c.subcategories containsObject:name]) return c.icon;
    }
    return nil;
}
@end
