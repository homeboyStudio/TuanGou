//
//  TGInfoTextView.m
//  点评团购
//
//  Created by homeboy on 14/12/2.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGInfoTextView.h"
#import "UIImage+HomeboyAdd.h"
@implementation TGInfoTextView

+ (id)infoTextView
{
    return [[NSBundle mainBundle] loadNibNamed:@"TGInfoTextView" owner:nil options:nil][0];
}
- (void)setIcon:(NSString *)icon
{
    _icon = icon;
    [_titleView setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    [_titleView setTitle:title forState:UIControlStateNormal];
}
- (void)setContent:(NSString *)content
{
    _content= content;
    _contentView.text = content;
    
//    CGFloat h = [content sizeWithFont:_contentView.font constrainedToSize:CGSizeMake(_contentView.frame.size.width, MAXFLOAT) lineBreakMode:_contentView.lineBreakMode].height + 20;
    NSDictionary *sizeDic = @{NSFontAttributeName:_contentView.font};
    CGFloat h = [content boundingRectWithSize:CGSizeMake(_contentView.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:sizeDic context:nil].size.height + 20;
    CGRect f = _contentView.frame;
    //高度差
    CGFloat contentDel = h - f.size.height;
    f.size.height = h;
    _contentView.frame = f;
    //调整整个View的高度
    CGRect allF = self.frame;
    allF.size.height += contentDel;
    self.frame = allF;
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //将背景图填充
    [[UIImage resizedImage:@"bg_order_cell.png"] drawInRect:rect];

}
@end
