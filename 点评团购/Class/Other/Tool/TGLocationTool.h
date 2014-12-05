//
//  TGLocationTool.h
//  点评团购
//
//  Created by homeboy on 14/12/4.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class City;
@interface TGLocationTool : NSObject
singleton_interface(TGLocationTool)
@property(nonatomic,strong)City *locationCity; //定位的当前位置
@end
