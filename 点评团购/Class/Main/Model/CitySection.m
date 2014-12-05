//
//  CitySection.m
//  点评团购
//
//  Created by homeboy on 14/11/22.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "CitySection.h"
#import "City.h"
#import "NSObject+Value.h"
@implementation CitySection
- (void)setCities:(NSMutableArray *)cities
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in cities) {
        if (![dic isKindOfClass:[NSDictionary class]]) {
            _cities = cities;
            return;
        }
        City *city = [[City alloc]init];
        [city setValues:dic];
        [array addObject:city];
    }
    _cities = array;

}
@end
