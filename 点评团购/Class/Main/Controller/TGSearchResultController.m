//
//  TGSearchResultController.m
//  点评团购
//
//  Created by homeboy on 14/11/23.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGSearchResultController.h"
#import "TGMetaDataTool.h"
#import "City.h"

#import "PinYin4Objc.h"
@interface TGSearchResultController ()
{
    NSMutableArray *_resultCities;  // 放着所有搜索到的城市
}
@end
@implementation TGSearchResultController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _resultCities = [NSMutableArray array];
}
- (void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    
    // 1.清除之前的搜索结果
    [_resultCities removeAllObjects];
    
    // 2.筛选城市
    //格式
    HanyuPinyinOutputFormat *fmt = [[HanyuPinyinOutputFormat alloc] init];
    fmt.caseType = CaseTypeUppercase;     //大写
    fmt.toneType = ToneTypeWithoutTone;   //不要音调
    fmt.vCharType = VCharTypeWithUUnicode;
    
    NSDictionary *cities = [TGMetaDataTool sharedTGMetaDataTool].totalCities;
    //遍历所有城市，取出名字筛选
    [cities enumerateKeysAndObjectsUsingBlock:^(NSString *key,  City *obj, BOOL *stop) {
        // SHI#JIA#ZHUANG
        // 1.拼音
        NSString *pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:obj.name withHanyuPinyinOutputFormat:fmt withNSString:@"#"];
        
        // 2.拼音首字母
        NSArray *words = [pinyin componentsSeparatedByString:@"#"];
        NSMutableString *pinyinHeader = [NSMutableString string];
        for (NSString *word in words) {
            [pinyinHeader appendString:[word substringToIndex:1]];  //拼接城市首字母
        }
        
        /*
         补充：这里少加一行代码    将分隔符替换为空
         */
        pinyin = [pinyin stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        // 3.城市名中包含了搜索条件
        // 拼音中包含了搜索条件
        // 拼音首字母中包含了搜索条件
        if (([obj.name rangeOfString:searchText].length != 0) ||
            ([pinyin rangeOfString:searchText.uppercaseString].length != 0)||
            ([pinyinHeader rangeOfString:searchText.uppercaseString].length != 0) //开头拼音
            )
        {
            // 说明城市名中包含了搜索条件
            [_resultCities addObject:obj];
        }
    }];
    
    // 3.刷新表格
    [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共%d个搜索结果", _resultCities.count];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    City *city = _resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    City *city = _resultCities[indexPath.row];
    
    [TGMetaDataTool sharedTGMetaDataTool].currentCity = city;
}
@end
