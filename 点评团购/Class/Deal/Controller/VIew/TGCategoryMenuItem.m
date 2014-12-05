//
//  TGCategoryMenuItem.m
//  点评团购
//
//  Created by homeboy on 14/11/24.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGCategoryMenuItem.h"
#import "Comment.h"
#import "TGCategory.h"

#define kTitleRatio 0.5
@implementation TGCategoryMenuItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [ super initWithFrame:frame];
    if (self) {
              
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

  
    }
    return self;
}

- (void)setCategory:(TGCategory *)category
{
    _category = category;
    [self setImage:[UIImage imageNamed:category.icon] forState:UIControlStateNormal];
    //标题
    [self setTitle:category.name forState:UIControlStateNormal];
}
#pragma mark - 设置按钮标题
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageHeight = contentRect.size.height * (1 - kTitleRatio);
    return CGRectMake(0, 0, contentRect.size.width, imageHeight);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleHeight = contentRect.size.height *kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight;
    return CGRectMake(0, titleY, contentRect.size.width,titleHeight);
}
- (NSArray *)titles
{
    return  _category.subcategories;
}
@end
