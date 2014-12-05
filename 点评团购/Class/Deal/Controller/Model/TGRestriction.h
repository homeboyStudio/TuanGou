//
//  TGRestrictions.h
//  点评团购
//
//  Created by homeboy on 14/12/1.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  团购限制条件
//  是否需要预约，0：不是，1：是
//	是否支持随时退款，0：不是，1：是
//  附加信息(一般为团购信息的特别提示)
#import <Foundation/Foundation.h>

@interface TGRestriction : NSObject
@property(nonatomic,assign) BOOL is_reservation_required;  //是否需要预约，0：不是，1：是
@property(nonatomic,assign) BOOL is_refundable;	          //是否支持随时退款，0：不是，1：是
@property(nonatomic,copy)NSString *special_tips;          //附加信息(一般为团购信息的特别提示)
@end
