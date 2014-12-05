//
//  TGBuyDock.m
//  点评团购
//
//  Created by homeboy on 14/11/30.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGBuyDock.h"
#import "TGDeal.h"
#import "TGCenterLineLabel.h"
#import "UIImage+HomeboyAdd.h"
@implementation TGBuyDock

- (void)setDeal:(TGDeal *)deal
{
    _deal = deal;
    NSString *price = [NSString stringWithFormat:@"%@ 元",deal.list_price_text];
    _listPrice.text = price; 
    _currentPrice.text = deal.current_price_text;
}
+ (id)buyDock
{
    return [[NSBundle mainBundle]loadNibNamed:@"TGBuyDock" owner:nil options:nil][0];
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //将背景图填充 
    [[UIImage resizedImage:@"bg_buyBtn.png"] drawInRect:rect];
}
@end
