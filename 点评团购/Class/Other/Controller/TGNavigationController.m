//
//  TGNavigationController.m
//  点评团购
//
//  Created by homeboy on 14/11/22.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGNavigationController.h"
#import "UIImage+HomeboyAdd.h"
@implementation TGNavigationController
- (void)viewDidLoad
{
    [super viewDidLoad];
}
#pragma mark - 第一次使用这个类只调用一次
+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    //设置导航栏的背景图案
    //    [bar setBackgroundImage:[UIImage  resizedImage:@"bg_navigation.png"] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏文字的主题
//    [bar setTitleTextAttributes:@{
//                                  UITextAttributeTextColor : [UIColor blackColor],
//                                  UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero]
//                                  }];
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowOffset: CGSizeMake(0.0f, 0.0f)];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSShadowAttributeName:shadow}];
    //修改所有UIBarButtonItem的外观
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //修改item的背景图案
        [item setBackgroundImage:[UIImage resizedImage:@"bg_navigation_right.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [item setBackgroundImage:[UIImage resizedImage:@"bg_navigation_right_hl.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    //修改item上的文字样式
//    NSDictionary *dic = @{
//                          UITextAttributeTextColor : [UIColor blackColor],
//                          UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
//                          UITextAttributeFont : [UIFont systemFontOfSize:14]
//                          };
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14],NSShadowAttributeName:shadow};
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    [item setTitleTextAttributes:dic forState:UIControlStateHighlighted];
    //设置状态栏样式
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
}
@end
