//
//  TGDealInfoController.m
//  点评团购
//
//  Created by homeboy on 14/12/1.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGDealInfoController.h"
#import "TGInfoHeaderView.h"
#import "TGDeal.h"
#import "TGRestriction.h"
#import "TGDealTool.h"
#import "TGInfoTextView.h"

#define kVMargin 20  //间距
@interface TGDealInfoController ()
{
    UIScrollView *_scrollView;
    TGInfoHeaderView *_header;
}
@end

@implementation TGDealInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加滚动视图
    [self addScrollView];
    //2.添加头部控件
    [self addHeaderView];
    //3.加载更加详细的团购数据
    [self loadDeetailDeal:_deal.deal_id];
}
#pragma mark - 添加滚动视图
- (void)addScrollView
{
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.bounds = CGRectMake(0, 0, 430, self.view.frame.size.height);
    CGFloat x = self.view.frame.size.width *0.5;
    CGFloat y = self.view.frame.size.height *0.5;
    _scrollView.center = CGPointMake(x, y);
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleLeftMargin |   UIViewAutoresizingFlexibleRightMargin;
    CGFloat height = 75;
    _scrollView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
}
#pragma mark - 添加头部控件
- (void)addHeaderView
{
    _header = [TGInfoHeaderView infoHeaderView];
    _header.deal = _deal;
    _header.frame = CGRectMake(0, 0, _scrollView.frame.size.width, _header.frame.size.height);
    [_scrollView addSubview:_header];
}
#pragma mark - 加载更加详细的团购数据
- (void)loadDeetailDeal:(NSString *)ID
{
    //添加指示器
//    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicator.autoresizingMask = UIVie utoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//    CGFloat x = _scrollView.frame.size.width * 0.5;
//    CGFloat y = CGRectGetMaxY(_header.frame) + kVMargin;
//    indicator.center = CGPointMake(x, y);
//    [_scrollView addSubview:indicator];
//    [indicator startAnimating];
[[TGDealTool sharedTGDealTool]dealsWithID:ID success:^(TGDeal *deal) {
    _header.deal = deal;
    _deal = deal;
        //添加详情数据
    [self addDetailViews];
//    [indicator removeFromSuperview];
}
error:nil];
}
#pragma mark - 添加详情数据
- (void)addDetailViews
{
    //1.团购详情
    [self addTextView: @"ic_content.png" title:@"团购详情" content:_deal.details];
    //2.购买须知
    [self addTextView:@"ic_tip.png" title:@"购买须知" content:_deal.restrictions.special_tips];
//    //3. 重要通知
//    [self addTextView:@"ic_tip.png" title:@"重要通知" content:_deal.notice];
}
#pragma mark - 添加一个详细详情View
-  (void)addTextView:(NSString *)icon title:(NSString *)title content:(NSString *)content
{
    if (content.length == 0) return;
    TGInfoTextView *textView = [TGInfoTextView infoTextView];
    //拿到最后一个控件的y值就ok
    int count = _scrollView.subviews.count;
    UIView *last = nil;
    if (count == 0) {
        last = _scrollView.subviews[0];
    }else{
        last = _scrollView.subviews[count - 2];
        }
     CGFloat y = CGRectGetMaxY(last.frame) + kVMargin;
    CGFloat w =  _scrollView.frame.size.width;
    CGFloat h =  textView.frame.size.height;
    textView.frame = CGRectMake(0,y,w,h);
    
    textView.icon = icon;
    textView.title = title;
    textView.content = content;
    [_scrollView addSubview:textView];
    
    //4.设置scrollView的滚动内容
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(textView.frame) + kVMargin + 70);
   }
@end
