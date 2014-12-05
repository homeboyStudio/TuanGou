//
//  TGDistrictMenuItem.m
//  点评团购
//
//  Created by homeboy on 14/11/25.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGDistrictMenuItem.h"
#import "District.h"
@implementation TGDistrictMenuItem
- (void)setDistrict:(District *)district
{
    _district = district;
    [self setTitle:district.name forState:UIControlStateNormal];
}
- (NSArray *)titles
{
    return _district.neighborhoods;
}
@end
