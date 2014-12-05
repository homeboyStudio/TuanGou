//
//  TGBusiness.h
//  点评团购
//
//  Created by homeboy on 14/12/3.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGBusiness : NSObject
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *h5_url;
@property (nonatomic,assign)int ID;
@property (nonatomic,assign)double latitude;
@property (nonatomic,assign)double longitude;
@property (nonatomic,copy)NSString *name;
@end
