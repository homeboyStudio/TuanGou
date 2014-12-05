//
//  TGDelPosAnnotation.h
//  点评团购
//
//  Created by homeboy on 14/12/3.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@class TGDeal,TGBusiness;
@interface TGDelPosAnnotation : NSObject<MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,strong)TGDeal *deal;  //显示的是哪一个团购
@property (nonatomic,strong)TGBusiness *business; //显示的是那个商家
@property (nonatomic,copy)NSString *icon;
@end
