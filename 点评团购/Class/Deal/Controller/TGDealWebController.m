//
//  TGDealWebController.m
//  点评团购
//
//  Created by homeboy on 14/12/1.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGDealWebController.h"
#import "TGDeal.h"
#import "Comment.h"
@interface TGDealWebController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    UIActivityIndicatorView *_indicator; //活动指示器
}
@end

@implementation TGDealWebController

- (void)loadView
{
    _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.backgroundColor = kGlobalBg;
    _webView.scrollView.backgroundColor = kGlobalBg;
    _webView.delegate = self;
    self.view = _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *ID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
    NSString *url = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@",ID];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}
#pragma mark - 添加活动指示器

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat height = 75;
    webView.scrollView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
}
#pragma mark - 拦截webView的所有请求
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    NSLog(@"%@---%@",_deal.deal_h5_url,request.URL);
//    return YES;
//}
@end
