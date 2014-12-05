//
//  TGDistrictMenu.m
//  点评团购
//
//  Created by homeboy on 14/11/24.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGDistrictMenu.h"
#import "TGDistrictMenuItem.h"
#import "TGMetaDataTool.h"
#import "City.h"
#import "District.h"
#import "TGMetaDataTool.h"
#import "TGSubtitlesView.h"
#import "Comment.h"
@interface TGDistrictMenu()
{
    NSMutableArray *_menuItems;   //装所有的item
}
@end
@implementation TGDistrictMenu
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [ super initWithFrame:frame];
    if (self) {
        _menuItems = [NSMutableArray array];
        
        [self cityChange];
#pragma mark - 当城市改变时自动刷新下属城区
        //4.单独监听城市改变
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
    }
    return self;
}
- (void)cityChange
{
     //1.获取当前选中的城市
     City *city = [TGMetaDataTool sharedTGMetaDataTool].currentCity;
     //2.当前城市的所有区域
     NSMutableArray *districts = [NSMutableArray array];
     //2.1全部商区
     District *all = [[District alloc]init];
     all.name = kAllDistrict;
     [districts addObject:all];
     //2.2添加其他商区
     [districts addObjectsFromArray:city.districts];
     //遍历所有商区
     int count = districts.count;
     for (int i = 0; i < count; i++) {
     TGDistrictMenuItem *item = nil;
     if (i >= _menuItems.count) {  //不够
     item = [[TGDistrictMenuItem alloc]init];
     [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
     [_menuItems addObject:item];
     [_scrollView addSubview:item];
       }else{
     item = _menuItems[i];
        }
     item.hidden = NO;
     item.district = districts[i];
     item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
     //默认选中第0个Item
     if (i == 0) {
     item.selected = YES;
     _selectedItem = item;
       }else{
           item.selected = NO;
       }
   }
     //隐藏多余的item
     for (int i = count; i <_menuItems.count; i++) {
     TGDistrictMenuItem *item = _scrollView.subviews[i];
     item.hidden = YES;
     }
     //5.设置scrollView的内容尺寸
     _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
     //6.隐藏
     [_subtitlesView hide];
}
//- (void)settingSubtitlesView
//{
//    _subtitlesView.setTitleBlock = ^(NSString *title){
//        [TGMetaDataTool sharedTGMetaDataTool].currentDistricy = title;
//        NSLog(@"%@",title);
//    };
//    _subtitlesView.getTitleBlock = ^(){
//        return  [TGMetaDataTool sharedTGMetaDataTool].currentDistricy;
//    };
//}
- (void)subtitlesView:(TGSubtitlesView *)subtitlesView titleClick:(NSString *)title
{
 [TGMetaDataTool sharedTGMetaDataTool].currentDistricy = title;
     NSLog(@"%@",title);
}
- (NSString *)subtitlesViewGetCurrentTitle:(TGSubtitlesView *)subtitlesView
{
   return  [TGMetaDataTool sharedTGMetaDataTool].currentDistricy;
   
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
