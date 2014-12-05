//
//  TGDelPosAnnotation.m
//  点评团购
//
//  Created by homeboy on 14/12/3.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGDelPosAnnotation.h"
#import "TGMetaDataTool.h"
#import "TGDeal.h"
@implementation TGDelPosAnnotation
- (void)setDeal:(TGDeal *)deal
{
    _deal = deal;
    for (NSString *c  in deal.categories) {
        //从元数据对比中拿到category的图名称对比
        NSString *icon = [[TGMetaDataTool sharedTGMetaDataTool] iconWithCategoryName:c];
        if (icon) {
            _icon = [icon stringByReplacingOccurrencesOfString:@"filter_" withString:@""];
            break;
        }
    }
}
@end
