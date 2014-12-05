//
//  DPAPI.h
//  apidemo
//
//  Created by ZhouHui on 13-1-28.
//  Copyright (c) 2013年 Dianping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPRequest.h"
#import "Singleton.h"
                 //请勿做坏事，XD
#define kDPAppKey             @"5595035655"
#define kDPAppSecret          @"9e6a9d3cfe5d4ca99e81ca8143879257"

#ifndef kDPAppKey
#error
#endif

#ifndef kDPAppSecret
#error
#endif

@interface DPAPI : NSObject
singleton_interface(DPAPI)

- (DPRequest*)requestWithURL:(NSString *)url
					  params:(NSDictionary *)params
					delegate:(id<DPRequestDelegate>)delegate;

- (DPRequest *)requestWithURL:(NSString *)url
				 paramsString:(NSString *)paramsString
					 delegate:(id<DPRequestDelegate>)delegate;

@end
