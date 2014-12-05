//
//  TGMapController.m
//  点评团购
//
//  Created by homeboy on 14/11/22.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//


#import "TGMapController.h"
#import "TGDealTool.h"
#import "TGDelPosAnnotation.h"
#import "TGBusiness.h"
#import "TGDeal.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Comment.h"
#import "TGCover.h"
#import "TGDealDetailController.h"
#import "TGNavigationController.h"
#import "UIBarButtonItem+WB.h"
#define kItemW 250
#define kItemH 250
#define kDetailWidth 600
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface TGMapController()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    TGCover *_cover;  //蒙版遮盖
    CLLocationManager *location;
    MKMapView *_mapView;
    NSMutableArray *_showingDeals;
}
@end
@implementation TGMapController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title  = @"地图";
    //
   
     MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [mapView setShowsUserLocation:YES];
    mapView.delegate = self;
    [self.view addSubview:mapView];
    
    //如果是iOS8之后的版本需要判断用户是否允许程序在后台执行
    if (IS_OS_8_OR_LATER) {
        location = [[CLLocationManager alloc]init];
        location.delegate= self;
//        [location requestAlwaysAuthorization];
//        [location requestWhenInUseAuthorization];
    }
    //初始化数组
    _showingDeals = [NSMutableArray array];

}
#pragma  mark - mapKit delegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    if (_mapView) return;
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.018404,0.031468);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [mapView setRegion:region animated:YES];
//    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
//    _mapView = mapView;
}
//拖动地图（地图展示的区域改变了）
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    //当前展示区域的中心位置
    CLLocationCoordinate2D pos = mapView.region.center;
  [[TGDealTool sharedTGDealTool] dealsWithPosition:pos success:^(NSArray *deals, int totalConut) {
      for (TGDeal *d in deals) {
          //已经显示过不需要重新显示
          if([_showingDeals containsObject:d]) break;
          [_showingDeals addObject:d];
          for (TGBusiness *b in d.businesses) {
              TGDelPosAnnotation *anno = [[TGDelPosAnnotation alloc]init];
              anno.business = b;
              anno.deal = d;
              anno.coordinate = CLLocationCoordinate2DMake(b.latitude, b.longitude);
              [mapView addAnnotation:anno];
          }
      }
  } error:^(NSError *error) {
      NSLog(@"拖拽地图获得团购地区失败,%@",[error localizedDescription]);
  }];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(TGDelPosAnnotation *)annotation
{
 
    if (![annotation isKindOfClass:[TGDelPosAnnotation class]]) return nil;
    //从缓存池中取出大头针的view
    static NSString *ID = @"annotation";
   MKAnnotationView *annoView =  [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annoView == nil) {
        annoView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ID];
    }
    //设置View的大头针信息
    annoView.annotation = annotation;
    annoView.image = [UIImage imageNamed:annotation.icon];
    return annoView;
}
#pragma mark - 点击了大头针
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //展示详情
    TGDelPosAnnotation *anno = view.annotation;
//    NSLog(@"%@",anno.deal.title);
    //让选中的大头针居中
    [mapView setCenterCoordinate:anno.coordinate animated:YES];
    //让View周边产生一些阴影效果
    view.layer.shadowColor = [UIColor orangeColor].CGColor;
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 20;
    [self showDetail:anno.deal];
}
#pragma mark - coreLocation delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
           switch (status) {
            case kCLAuthorizationStatusNotDetermined:
                if ([location respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                    [location requestAlwaysAuthorization];
                }
                break;
            default: 
                break;
        } 
}
#pragma mark - 显示详情控制器
- (void)showDetail:(TGDeal *)deal
{
    //1.显示遮盖
    if (_cover == nil) {
        _cover = [TGCover cover];
        [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideDetail)]];
    }
    _cover.frame = self.navigationController.view.bounds;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        [_cover resetAlpha];
    }];
    [self.navigationController.view addSubview:_cover];
    //2.展示团购详细控制器
    TGDealDetailController *detail = [[TGDealDetailController alloc]init];
    detail.deal = deal;
    detail.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithIcon:@"btn_nav_close.png" highlightedIcon:@"btn_nav_close_hl.png" tagert:self action:@selector(hideDetail)];
    TGNavigationController *nav = [[TGNavigationController alloc]initWithRootViewController:detail];
    nav.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    [nav.view setFrame:CGRectMake( _cover.frame.size.width,0,kDetailWidth, _cover.frame.size.height)];
    //当两个控制器互为父子关系时，它们的view也是互为父子关系
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    //3.动画弹出详细控制器
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        CGRect  f = nav.view.frame;
        f.origin.x -= kDetailWidth;
        nav.view.frame = f;
    }];
    //监听拖拽手势监听
    [nav.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)]];
}
//拖拽效果
- (void)drag:(UIPanGestureRecognizer *)pan
{
    CGFloat tx = [pan translationInView:pan.view].x;
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat halfW = pan.view.frame.size.width * 0.5;
        if (tx>=halfW ) {  //往右拖动
            [self hideDetail];
        }else{
            [UIView animateWithDuration:kDefaultAnimDuration animations:^{
                pan.view.transform = CGAffineTransformIdentity;
            }];
        }
    }else{
        if (tx < 0) { //向左拉伸
            tx *= 0.4;
        }
        pan.view.transform = CGAffineTransformMakeTranslation(tx, 0);
    }
}
#pragma mark - 隐藏详情控制器,关闭遮盖
- (void)hideDetail
{  UIViewController *nav = self.navigationController.childViewControllers.lastObject;
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        //1.隐藏遮盖
        _cover.alpha = 0;
        //2.隐藏控制器
        CGRect f = nav.view.frame;
        f.origin.x += kDetailWidth;
        nav.view.frame = f;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        [nav.view removeFromSuperview];
        [nav removeFromParentViewController];
    }];
}
@end
