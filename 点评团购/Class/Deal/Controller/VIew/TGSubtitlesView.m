//
//  TGSubtitlesView.m
//  点评团购
//
//  Created by homeboy on 14/11/25.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "Comment.h"
#import "UIImage+HomeboyAdd.h"
#import "TGSubtitlesView.h"
#import "TGMetaDataTool.h"
#define kTitleW 100
#define kTitleH 40
@interface TGSubtitlesView()
{
    UIButton *_selectedBtn;
}
@end
@implementation TGSubtitlesView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [ super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self setImage:[UIImage resizedImage:@"bg_subfilter_other.png"]];
        //裁减掉超出父控件范围内的子控件
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;

}
#pragma mark - 监听小标题
- (void)titleClick:(UIButton *)btn
{
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn =btn;
//    if (_setTitleBlock) {
//        _setTitleBlock([btn titleForState:UIControlStateNormal]);
//    }
    if ([_delegate respondsToSelector:@selector(subtitlesView:titleClick:)]) {
        NSString *title = [btn titleForState:UIControlStateNormal];
        if ([title  isEqualToString:kAll]) {  //全部------改成二级菜单的标题
            title = _mainTitle;
        }
        [_delegate subtitlesView:self titleClick:title];
    }
}
- (void)setTitles:(NSArray *)titles
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:kAll];
    [array addObjectsFromArray:titles];
    _titles = array;
    
    int count = _titles.count;
    // 设置按钮的文字
    for (int i = 0; i< count; i++) {
        // 1.取出i位置对应的按钮
        UIButton *btn = nil;
        if (i >= self.subviews.count) { // 按钮个数不够
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_active.png"] forState:UIControlStateSelected];
            [self addSubview:btn];
        } else {
            btn = self.subviews[i];
        }
        // 2.设置按钮文字
        btn.hidden = NO;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        //根据按钮文字来决定要不要选中
        if ([_delegate respondsToSelector:@selector(subtitlesViewGetCurrentTitle:)]) {
            NSString *current = [_delegate subtitlesViewGetCurrentTitle:self];
            //选中了主标题,选中第0个按钮("全部按钮")
            if([current isEqualToString:_mainTitle]&&i == 0){
                btn.selected = YES;
                _selectedBtn = btn;
            }else{
            btn.selected = [_titles[i] isEqualToString:current];
            if (btn.selected) {
                _selectedBtn = btn;
                }
             }
                }else{
                        btn.selected = NO;
                }
//        if (_getTitleBlock) {
//            NSString *current = _getTitleBlock();
//            btn.selected = [titles[i] isEqualToString:current];
//        }else{
//            btn.selected = NO;
//        }
    }
    
    // 隐藏后面多余的按钮
    for (int i = count; i<self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.hidden = YES;
    }
    [self layoutSubviews];
}

//控件本身的宽高发生改变的时候需要调用
- (void)layoutSubviews
{
    // 一定要调用super
    [super layoutSubviews];
    
    int columns = self.frame.size.width / kTitleW;
    for (int i = 0; i<_titles.count; i++) {
        UIButton *btn = self.subviews[i];
        
        // 设置位置
        CGFloat x = i % columns * kTitleW;
        CGFloat y = i / columns * kTitleH;
        btn.frame = CGRectMake(x, y, kTitleW, kTitleH);
    }
    
//        [UIView animateWithDuration:4 animations:^{
    int rows = (_titles.count + columns - 1) / columns;
    CGRect frame = self.frame;
    frame.size.height = rows * kTitleH;
    self.frame = frame;
//        }];
}
- (void)show
{
    [self layoutSubviews];
    
    self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
    self.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        CGRect f = self.frame;
        f.size.height = 0;
        self.frame = f;
        
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}@end
