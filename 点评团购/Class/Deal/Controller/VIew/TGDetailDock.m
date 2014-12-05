//
//  TGDetailDock.m
//  点评团购
//
//  Created by homeboy on 14/12/1.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGDetailDock.h"
@interface TGDetailDock()
{
    UIButton *_selectedBtn;
}
@end
@implementation TGDetailDock

- (void)setFrame:(CGRect)frame
{
    frame.size  = self.frame.size;
    [super setFrame:frame];
}
+ (id)detailDock;
{
    return [[NSBundle mainBundle]loadNibNamed:@"TGDetailDock" owner:nil options:nil][0];
}
- (void)awakeFromNib
{
    //默认选中第一个
    [self btnClick:_infoBtn];
}
- (IBAction)btnClick:(UIButton *)sender {
    //通知代理
    if ([_delegate respondsToSelector:@selector(detailDock:btnClickFrom:to:)]) {
        [_delegate detailDock:self btnClickFrom:_selectedBtn.tag to:sender.tag];
    }
    _selectedBtn.enabled = YES;
    sender.enabled = NO;
    _selectedBtn = sender;
    //2.将添加被点击按钮在最上面
    if (sender == _infoBtn) {
        [self insertSubview:_merchantBtn atIndex:0];
    }else if (sender == _merchantBtn){
        [self insertSubview:_infoBtn atIndex:0];
    }
    [self bringSubviewToFront:sender];
}
@end
@implementation TGDetailDockItem
- (void)setHighlighted:(BOOL)highlighted{}
@end
