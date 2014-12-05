//
//  City.h
//  点评团购
//
//  Created by homeboy on 14/11/22.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGBaseModel.h"
#import <CoreLocation/CoreLocation.h>
@interface City : TGBaseModel
@property (nonatomic,strong)NSArray *districts; //分区
@property (nonatomic,assign)BOOL hot;

@property (nonatomic,assign)CLLocationCoordinate2D position;
@end
