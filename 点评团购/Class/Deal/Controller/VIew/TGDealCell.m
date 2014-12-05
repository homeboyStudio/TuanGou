//
//  TGDealCell.m
//  点评团购
//
//  Created by homeboy on 14/11/29.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGDealCell.h"
#import "TGDeal.h"
#import "TGImageTool.h"
@implementation TGDealCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [ super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
#pragma mark - 重写setter方法将传来的数据赋给cell
- (void)setDeal:(TGDeal *)deal
{
    _deal = deal;
    //1.设置描述
    _desc.text = deal.desc;
    //2.下载图片
    [TGImageTool downloadImage:deal.image_url placehoder:[UIImage imageNamed:@"placeholder_deal.png"] imageView:_image];
    //3.购买人数
    [_purchaseCount setTitle:[NSString stringWithFormat:@"%d",deal.purchase_count] forState:UIControlStateNormal];
    //4.价格
    _price.text = deal.current_price_text;
    //5.标签
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *now = [fmt stringFromDate: [NSDate date]];
   //将时间进行比较
    if([deal.publish_date isEqualToString:now]){
        _badge.hidden = NO;
        _badge.image = [UIImage imageNamed:@"ic_deal_new.png"];
    }else if ([deal.purchase_deadline isEqualToString:now]){
        _badge.hidden = NO;
        _badge.image = [UIImage imageNamed:@"ic_deal_soonOver.png"];
    }else if([deal.purchase_deadline compare:now] == NSOrderedAscending){
        _badge.hidden = NO;
        _badge.image = [UIImage imageNamed:@"ic_deal_over.png"];
    }
}
@end
