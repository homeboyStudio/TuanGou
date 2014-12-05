//
//  TGCategoryMenu.m
//  点评团购
//
//  Created by homeboy on 14/11/24.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGCategoryMenu.h"
#import "TGMetaDataTool.h"
#import "TGCategoryMenuItem.h"
#import "TGCategory.h"
#import "Comment.h"
#import "TGSubtitlesView.h"
#import "TGMetaDataTool.h"
@interface TGCategoryMenu()
{
    TGSubtitlesView *_subtitlesView;  //子标题View
}
@end
@implementation TGCategoryMenu
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *categories = [TGMetaDataTool sharedTGMetaDataTool].totalCategories;
        //1.往scrollView里面添加内容
        int count = categories.count;
        for (int i = 0; i < count; i++) {
            TGCategory *c = categories[i];
            //创建item
            TGCategoryMenuItem *item = [[TGCategoryMenuItem alloc]init];
            item.category = c;
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            item.frame = CGRectMake( i * kBottomMenuItemW, 0, 0, 0);
            [_scrollView addSubview:item];
            //默认选中第0个Item
            if (i == 0) {
                item.selected = YES;
                _selectedItem = item;
            }
        }
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    }
    return self;
}
- (void)hide
{
    [super hide];
    [_subtitlesView hide];
}
//- (void)settingSubtitlesView
//{
//    _subtitlesView.setTitleBlock = ^(NSString *title){
//        [TGMetaDataTool sharedTGMetaDataTool].currentCategory = title;
//        NSLog(@"%@",title);
//    };
//    _subtitlesView.getTitleBlock = ^(){
//        return  [TGMetaDataTool sharedTGMetaDataTool].currentCategory;
//    };
//}
- (void)subtitlesView:(TGSubtitlesView *)subtitlesView titleClick:(NSString *)title
{
 [TGMetaDataTool sharedTGMetaDataTool].currentCategory = title;
    NSLog(@"%@",title);
}
- (NSString *)subtitlesViewGetCurrentTitle:(TGSubtitlesView *)subtitlesView
{
    return  [TGMetaDataTool sharedTGMetaDataTool].currentCategory;
}
@end
