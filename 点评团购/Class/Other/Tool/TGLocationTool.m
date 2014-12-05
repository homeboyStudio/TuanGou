//
//  TGLocationTool.m
//  点评团购
//
//  Created by homeboy on 14/12/4.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGLocationTool.h"
#import <CoreLocation/CoreLocation.h>
#import "TGMetaDataTool.h"
#import "City.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface TGLocationTool()<CLLocationManagerDelegate>
{
    CLLocationManager *_manager;
    CLGeocoder *_geo;
}
@end
@implementation TGLocationTool
singleton_implementation(TGLocationTool)

- (instancetype)init
{
    self = [super init];
    if (self) {
        //2.
        _manager = [[CLLocationManager alloc]init];
         _geo = [[ CLGeocoder alloc]init];
        _manager.delegate = self;
        [_manager startUpdatingLocation];

    }
    return self;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //停止定位
    [_manager stopUpdatingLocation];
    //根据经纬度反向获得城市的名称
    CLLocation *location = locations[0];
    [_geo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
         CLPlacemark *place =  placemarks[0];
        NSString *name = place.locality;
#warning ------在iOS8下我还没有解决反编译位置的中文本地化，所以需要判断自行添加
        if ([name isEqualToString:@"Shanghai"]) {
            name = @"上海";
        }else if([name isEqualToString:@"Hangzhou"]){
        name = @"杭州";
        }else if([name isEqualToString:@"Beijing"]){
        name = @"北京";
        }else if ([name isEqualToString:@"Nanjing"]){
        name = @"南京";
        }else if ([name isEqualToString:@"Guangzhou"]){
        name = @"广州";
        }else if ([name isEqualToString:@"Suzhou"]){
        name = @"苏州";
        }else{
        name = @"上海";
        }
        if ([name containsString:@"市"]) {
        name = [name substringToIndex:name.length - 1];
        }
            City *city = [TGMetaDataTool sharedTGMetaDataTool].totalCities[name];
        [TGMetaDataTool sharedTGMetaDataTool].currentCity = city;
        _locationCity = city;
        _locationCity.position = location.coordinate;
    }];
}
#pragma mark - coreLocation delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([_manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [_manager requestAlwaysAuthorization];
            }
            break;
        default:
            break;
    }
}
@end
