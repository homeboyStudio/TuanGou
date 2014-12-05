//
//  TGInfoHeaderView.m
//  点评团购
//
//  Created by homeboy on 14/12/1.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGInfoHeaderView.h"
#import "UIImage+HomeboyAdd.h"
#import "TGDeal.h"
#import "TGRestriction.h"
#import "TGImageTool.h"
@implementation TGInfoHeaderView
- (void)setDeal:(TGDeal *)deal
{
    _deal = deal;
      //1.下载图片
    [TGImageTool downloadImage:deal.image_url placehoder:[UIImage imageNamed:@"placeholder_deal.png"] imageView:_image];
    //2.购买人数
    NSString *people = [NSString stringWithFormat:@"%d 人已购买",deal.purchase_count];
    [_purchaseCount setTitle:people forState:UIControlStateNormal];
    //3.设置剩余时间
    NSString *lastTime = [NSString stringWithFormat:@"%@ 过期",deal.purchase_deadline];
    [_time setTitle:lastTime forState:UIControlStateNormal];
    //4.是否支持过期退款
    _anyTimeBack.enabled =  _deal.restrictions.is_refundable;
    _expireBack.enabled = _anyTimeBack.enabled;
    //5.设置描述
    _desc.text = _deal.desc;
//    CGFloat descH = [deal.desc sizeWithFont:_desc.font constrainedToSize:CGSizeMake(_desc.frame.size.width,MAXFLOAT) lineBreakMode:_desc.lineBreakMode].height + 20;
    NSDictionary *sizeDic = @{NSFontAttributeName:_desc.font};
    CGFloat descH = [deal.desc boundingRectWithSize:CGSizeMake(_desc.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:sizeDic context:nil].size.height + 20;
    CGRect f = _desc.frame;
    //字体高度与label的高度差
    CGFloat descDeltaH = descH - f.size.height;
    f.size.height = descH;
    _desc.frame = f;
    //6.调整整体的高度
    CGRect selfF = self.frame;
    selfF.size.height += descDeltaH;
    self.frame = selfF;
   }
+ (id)infoHeaderView
{
    return [[NSBundle mainBundle]loadNibNamed:@"TGInfoHeaderView" owner:nil options:nil][0];
}

#pragma mark - 添加背景图案
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //将背景图填充
    [[UIImage resizedImage:@"bg_order_cell.png"] drawInRect:rect];
}

@end
