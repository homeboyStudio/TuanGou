//
//  TGDealTopMenu.m
//  点评团购
//
//  Created by homeboy on 14/11/24.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "Comment.h"
#import "TGDealTopMenu.h"
#import "TGDealTopMenuItem.h"
#import "TGCategoryMenu.h"
#import "TGDistrictMenu.h"
#import "TGOrderMenu.h"
#import "TGMetaDataTool.h"
#import "TGOrder.h"
@interface TGDealTopMenu()
{
    TGDealTopMenuItem *_selectedItem;  //选中的item
    
    TGCategoryMenu  *_cMenu;  //分类菜单
    TGDistrictMenu  *_dMenu;  //区域菜单
    TGOrderMenu     *_oMenu;  //排序菜单
    TGDealBottomMenu *_showMenu;  //正在展示的底部菜单
    
    TGDealTopMenuItem *_cItem;
     TGDealTopMenuItem *_dItem;
     TGDealTopMenuItem *_oItem;
}
@end
@implementation TGDealTopMenu
#pragma mark - 添加团购栏按钮
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 1.全部分类
        _cItem = [self addMenuItem:kAllCategory index:0];
        
        // 2.全部商区
       _dItem = [self addMenuItem:kAllDistrict index:1];
        
        // 3.默认排序
        _oItem = [self addMenuItem:@"默认排序" index:2];
        
        //4.监听通知
          kAddAllNotes(dataChange)
    }
    return self;
}
#pragma mark - 监听通知
- (void)dataChange
{
    _selectedItem.selected = NO;
    _selectedItem = nil;
    //1.分类按钮文字
 NSString *c = [TGMetaDataTool sharedTGMetaDataTool].currentCategory;
    if (c) {
        _cItem.title = c;
    }
    //2.商区按钮
    NSString *d = [TGMetaDataTool sharedTGMetaDataTool].currentDistricy;
    if (d) {
        _dItem.title = d;
    }
    //3.排序按钮
    NSString *o = [TGMetaDataTool sharedTGMetaDataTool].currentOrder.name;
    if (o) {
        _oItem.title = o;
    }
    //隐藏底部菜单
    [_showMenu hide];
    _showMenu = nil;
}
#pragma mark 添加一个菜单项
- (TGDealTopMenuItem *)addMenuItem:(NSString *)title index:(int)index
{
    TGDealTopMenuItem *item = [[TGDealTopMenuItem alloc] init];
    item.title = title;
    item.tag = index;
    item.frame = CGRectMake(kTopMenuItemW * index, 0, 0, 0);
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
    return item;
}
#pragma mark - 监听按钮点击
- (void)itemClick:(TGDealTopMenuItem *)item
{
    //没有选择城市，不允许点击顶部菜单
    if ([TGMetaDataTool sharedTGMetaDataTool].currentCity == nil) return;
    // 1.控制选中状态
    _selectedItem.selected = NO;
    if (_selectedItem == item) {
        _selectedItem = nil;
        // 隐藏底部菜单
        [self hideBottomMenu];
    } else {
        item.selected = YES;
        _selectedItem = item;
        // 显示底部菜单
        [self showBottomMenu:item];
    }
}
#pragma mark - 展现菜单
- (void)showBottomMenu:(TGDealTopMenuItem *)button
{
    //判断是否需要动画
    BOOL animated = _showMenu == nil;
    //移除当前正在显示的菜单
    [_showMenu removeFromSuperview];
    //显示底部菜单
    if (button.tag == 0) { //分类
        if (!_cMenu) {
            _cMenu  = [[TGCategoryMenu alloc]init];
              // menu.frame = _contentView.frame;   //{{0, 0}, {924, 768}}
         }
        _showMenu = _cMenu;
    }else if (button.tag == 1){       //商区
        if (!_dMenu) {
            _dMenu = [[TGDistrictMenu alloc]init];
        }
        _showMenu = _dMenu;
    }else{                            //排序
        if (!_oMenu) {
            _oMenu = [[TGOrderMenu alloc]init];
        }
        _showMenu = _oMenu;
    }
    _showMenu.frame = _contentView.bounds;
#pragma - mark block  监听点击了蒙版
    __unsafe_unretained TGDealTopMenu *menu = self;
    _showMenu.hideBlock = ^{
        menu->_selectedItem.selected = NO;
       menu->_selectedItem = nil;
        menu->_showMenu = nil;
    };
    [_contentView addSubview:_showMenu];

    //执行菜单出现的动画
    if (animated) {
        [_showMenu show];
    }
}
#pragma -mark 隐藏菜单
- (void)hideBottomMenu
{
    [_showMenu hide];
    _showMenu = nil;
}
- (void)setFrame:(CGRect)frame
{
    frame = CGRectMake(0,0,3*kTopMenuItemW, kTopMenuItemH);
    [super setFrame:frame];
}
@end
