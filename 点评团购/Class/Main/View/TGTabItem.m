//
//  TGTabItem.m
//  点评团购
//
//  Created by homeboy on 14/11/21.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGTabItem.h"

@implementation TGTabItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.设置选中时候的背景
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item.png"] forState:UIControlStateDisabled];
    }
    return self;
}
-(void)setEnabled:(BOOL)enabled
{
        //用来控制顶部分割线
    _divider.hidden = !enabled;
    [super setEnabled:enabled];
    
}
@end
