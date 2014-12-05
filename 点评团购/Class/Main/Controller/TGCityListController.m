//
//  TGCityListController.m
//  点评团购
//
//  Created by homeboy on 14/11/22.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "Comment.h"
#import "TGCityListController.h"
#import "CitySection.h"
#import "NSObject+Value.h"
#import "City.h"
#import "TGMetaDataTool.h"
#import "TGSearchResultController.h"
#import "TGCover.h"
@interface TGCityListController()<UISearchBarDelegate>
{
    NSMutableArray *_citySection; //所有城市组信息
    TGCover *_cover;      //蒙版
    UITableView *_tableView;
    
    TGSearchResultController *_searchResult;
    UISearchBar *_searchBar;

}
@end
@implementation TGCityListController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //1.添加搜索框
    [self addSerachBar];
    //2.添加表格
    [self addTableView];
    //3.加载数据
    [self loadCityData];
}
- (void)addSerachBar
{
    UISearchBar *search  = [[UISearchBar alloc]init];
    search.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    search.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    search.delegate  = self;
    _searchBar = search;
    _searchBar.placeholder = @"请输入城市名或拼音";
    [self.view addSubview:search];
}
- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    [tableView setFrame:CGRectMake(0, 44,  self.view.frame.size.width, self.view.frame.size.height - 44)];
    tableView.dataSource = self;
    tableView.delegate =self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView = tableView;
    [self.view addSubview:tableView];
}
//加载城市数据
- (void)loadCityData
{
    _citySection = [NSMutableArray array];
    NSArray *sections = [TGMetaDataTool sharedTGMetaDataTool].totalCitySections;
    [_citySection addObjectsFromArray:sections];
  
}
#pragma mark - 搜索框的代理方法
 - (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        [_searchResult.view removeFromSuperview]; 
    }else{
        if (_searchResult == nil) {
            _searchResult = [[TGSearchResultController alloc]init];
            _searchResult.view.frame = _cover.frame;
            _searchResult.view.autoresizingMask = _cover.autoresizingMask;
            [self addChildViewController:_searchResult];
        }
        _searchResult.searchText = searchText;
        [self.view addSubview:_searchResult.view];
    }
}
#pragma mark - 搜索框开始编辑(开始聚焦)
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
//    [searchBar becomeFirstResponder];
//1.取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    //2.设置蒙版
    if (_cover == nil) {
        _cover = [[TGCover alloc]init];
        _cover = [TGCover cover];
        [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverClick)]];
    }
    _cover.frame = _tableView.frame;
    [self.view addSubview:_cover];
    _cover.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        [_cover resetAlpha];
    }];
}
//取消键盘点击
 - (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
      [self coverClick];
}
//点击cancel取消
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self coverClick];
}
#pragma mark - 监听点击蒙版
- (void)coverClick
{
    [UIView animateWithDuration:0.3 animations:^{
    _cover.alpha = 0.0;
     } completion:^(BOOL finished) {
    [_cover removeFromSuperview];
     }];
    [_searchBar setShowsCancelButton:NO animated:YES];
    [_searchBar resignFirstResponder];
}
#pragma mark - dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _citySection.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{      CitySection *s = _citySection[section];
        return   s.cities.count;
    
   }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CitySection *s = _citySection[indexPath.section];
       City *city = s.cities[indexPath.row];
       cell.textLabel.text =  city.name;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CitySection *s = _citySection[section];
    NSString *name =  s.name;
    return name;
}
//返回右边的索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [_citySection  valueForKeyPath:@"name"];
}
#pragma mark - tableView的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitySection *s = _citySection[indexPath.section];
    City *city = s.cities[indexPath.row];
    [TGMetaDataTool sharedTGMetaDataTool].currentCity = city;
   }
@end
