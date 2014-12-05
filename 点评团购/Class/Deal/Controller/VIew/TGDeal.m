//
//  TGDeal.m
//  点评团购
//
//  Created by homeboy on 14/11/28.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGDeal.h"
#import "TGRestriction.h"
#import "TGBusiness.h"
#import "NSObject+Value.h"
#import "NSString+FixScale.h"
@implementation TGDeal
- (void)setList_price:(double)list_price
{
    _list_price = list_price;
    _list_price_text = [NSString stringWithDouble:list_price fractionCount:2];
}
- (void)setCurrent_price:(double)current_price
{
    _current_price = current_price;
    _current_price_text = [NSString stringWithDouble:current_price fractionCount:2];
}
- (void)setRestrictions:(TGRestriction *)restrictions
{
    if ([restrictions isKindOfClass:[NSDictionary class]]) {
        _restrictions = [[TGRestriction alloc]init];
        [_restrictions setValues:(NSDictionary *)restrictions];
    }else{
        _restrictions = restrictions;
    }
}
- (void)setBusinesses:(NSArray *)businesses
{
    NSDictionary *obj = [businesses lastObject];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in businesses) {
            TGBusiness *b = [[TGBusiness alloc]init];
            [b setValues:dict];
            [temp addObject:b];
        }
        _businesses = temp;
    }else{
        _businesses = businesses;
    }
}
@end
