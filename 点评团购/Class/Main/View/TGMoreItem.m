//
//  TGMoreItem.m
//  点评团购
//
//  Created by homeboy on 14/11/21.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGMoreItem.h"
#import "TGMoreController.h"
#import "TGNavigationController.h"
@implementation TGMoreItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self setIcon:@"ic_more.png" selectedIco:@"ic_more_hl.png"];
        //监听点击
        [self addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}
#pragma mark - 
- (void)more
{
    self.enabled = NO; 
    //弹出更多地控制器
    TGMoreController *more = [[TGMoreController alloc]init];
    more.moreItem = self;
    TGNavigationController *nav = [[TGNavigationController alloc]initWithRootViewController:more];
    //展示类型
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}
@end
