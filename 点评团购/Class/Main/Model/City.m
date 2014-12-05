//
//  City.m
//  点评团购
//
//  Created by homeboy on 14/11/22.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "City.h"
#import "District.h"
#import "NSObject+Value.h"
@implementation City
-(void)setDistricts:(NSArray *)districts
{
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in districts) {
        District *district = [[District alloc]init];
        [district setValues:dic];
        [array addObject:district];
    }
    _districts = array;
}
@end
