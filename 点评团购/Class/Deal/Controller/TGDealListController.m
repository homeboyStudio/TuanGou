//
//  TGDealController.m
//  点评团购
//
//  Created by homeboy on 14/11/22.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "TGDealListController.h"
#import "TGNavigationController.h"
#import "UIBarButtonItem+WB.h"
#import "Comment.h"
#import "MJRefresh.h"
#import "TGDealTopMenu.h"
#import "TGMetaDataTool.h"
#import "TGDealCell.h"
#import "TGDealTool.h"
#import "TGImageTool.h"
#import "TGDeal.h"
#import "TGCover.h"
#import "TGDealDetailController.h"

//运行时机制将字典中的value装换为数据模型
#import "NSObject+Value.h"
#define kItemW 250
#define kItemH 250
#define kDetailWidth 600
@interface TGDealListController()<MJRefreshBaseViewDelegate>
{
    NSMutableArray *_deals;
    int _page;   //页码
    MJRefreshFooterView *_footer;
    MJRefreshHeaderView *_header;
    TGCover *_cover;  //蒙版遮盖
}
@end
@implementation TGDealListController
 -(instancetype)init
{ //流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置cell
    layout.itemSize = CGSizeMake(kItemW, kItemH);   //每一个网格的尺寸
    layout.minimumLineSpacing =  20;          //每一行之间的间距
    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //1.基本设置
    [self baseSetting];
    //2.添加刷新控件
    [self addRefresh];
   
}
- (void)baseSetting
{
    //1.监听城市改变的通知
    kAddAllNotes(dataChange)
    //self.collectionView 是self.view中的一个子控件
    self.collectionView.backgroundColor = kGlobalBg;
    //2.背景颜色
    //self.view.backgroundColor = kGlobalBg;
    //3.右边的搜索框
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.placeholder = @"请输入商品名或地址";
    searchBar.bounds = CGRectMake(0, 0, 160, 35);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBar];
    //4左边的菜单栏目
    TGDealTopMenu *menu = [[TGDealTopMenu alloc]init];
    menu.contentView = self.view;   //拿到根视图  {{0, 0}, {1024, 768}}
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menu];
    //5.注册cell要用到的xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"TGDealCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];
    //6.设置collectionView永远支持垂直滚动
    self.collectionView.alwaysBounceVertical = YES;
}
#pragma mark - 添加刷新控件
- (void)addRefresh
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.collectionView;
    header.delegate = self;
    _header = header;
   MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.collectionView;
    footer.delegate = self;
    _footer = footer;
}
#pragma mark - 刷新代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    BOOL isHeader = [refreshView isKindOfClass:[MJRefreshHeaderView class]];
    if (isHeader) {  //下拉刷新
        [TGImageTool clear];  //清除不必要的缓存
        _page = 1;   //第一页
           }else{  //上拉加载更多
        _page++;
            }
    [[TGDealTool sharedTGDealTool]dealsWithPage:_page success:^(NSArray *deals,int totalCount) {
        if(isHeader){
            _deals = [NSMutableArray array];
        }
        //1.添加数据
        [_deals addObjectsFromArray:deals];
        //2.刷新表格
        [self.collectionView reloadData];
        //3.恢复刷新状态
        [refreshView endRefreshing];
        //4.根据数量判断是否需要隐藏上拉控件
        _footer.hidden = _deals.count >=totalCount;
    } error:^(NSError *error) {
        [refreshView endRefreshing]; 
        MyLog(@"%@",[error localizedDescription]);
    }];

}
#pragma mark - 监听通知
- (void)dataChange
{
    [_header beginRefreshing];
}
#pragma mark - collection的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _deals.count;
}
#pragma mark - 刷新数据的时候会调用
#pragma mark - 每当有一个cell重新进入屏幕视野范围内就会调用！！！
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"deal";
   TGDealCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.deal = _deals[indexPath.row];
    return cell;
}
#pragma mark - collectionViewController代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetail:_deals[indexPath.row]];
  }
#pragma mark - 显示详情控制器
- (void)showDetail:(TGDeal *)deal
{
    //1.显示遮盖
    if (_cover == nil) {
        _cover = [TGCover cover];
        [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideDetail)]];
    }
    _cover.frame = self.navigationController.view.bounds;
    _cover.alpha = 0;  
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        [_cover resetAlpha];
    }];
    [self.navigationController.view addSubview:_cover];
    //2.展示团购详细控制器
    TGDealDetailController *detail = [[TGDealDetailController alloc]init];
    detail.deal = deal;
    detail.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithIcon:@"btn_nav_close.png" highlightedIcon:@"btn_nav_close_hl.png" tagert:self action:@selector(hideDetail)];
    TGNavigationController *nav = [[TGNavigationController alloc]initWithRootViewController:detail];
    nav.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        [nav.view setFrame:CGRectMake( _cover.frame.size.width,0,kDetailWidth, _cover.frame.size.height)];
    //当两个控制器互为父子关系时，它们的view也是互为父子关系
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    //3.动画弹出详细控制器
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        CGRect  f = nav.view.frame;
        f.origin.x -= kDetailWidth;
        nav.view.frame = f;
    }];
    //监听拖拽手势监听
    [nav.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)]];
}
//拖拽效果
- (void)drag:(UIPanGestureRecognizer *)pan
{
    CGFloat tx = [pan translationInView:pan.view].x;
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat halfW = pan.view.frame.size.width * 0.5;
        if (tx>=halfW ) {  //往右拖动
            [self hideDetail];
        }else{
            [UIView animateWithDuration:kDefaultAnimDuration animations:^{
                pan.view.transform = CGAffineTransformIdentity;
            }];
        }
    }else{
        if (tx < 0) { //向左拉伸
            tx *= 0.4;
        }
        pan.view.transform = CGAffineTransformMakeTranslation(tx, 0);
    }
}
#pragma mark - 隐藏详情控制器,关闭遮盖
- (void)hideDetail

{  UIViewController *nav = self.navigationController.childViewControllers.lastObject;
 [UIView animateWithDuration:kDefaultAnimDuration animations:^{
     //1.隐藏遮盖
     _cover.alpha = 0;
     //2.隐藏控制器
        CGRect f = nav.view.frame;
     f.origin.x += kDetailWidth;
     nav.view.frame = f;
 } completion:^(BOOL finished) {
     [_cover removeFromSuperview];
     [nav.view removeFromSuperview];
     [nav removeFromParentViewController];
 }];
}
#pragma mark - 在viewWillAppear和viewDidAppear中可以取得view最准确的宽高
- (void)viewWillAppear:(BOOL)animated
{
    //6.默认计算layout
    [self didRotateFromInterfaceOrientation:0];
}
#pragma mark - 控制器方法,屏幕即将旋转时调用
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //1.取出layout
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    CGFloat v = 20;
    CGFloat h = 0;
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))  //横屏
    {
        h = (self.view.frame.size.width - 3*kItemW) / 4;
    }else{
        h = (self.view.frame.size.width - 2*kItemW) / 3;
    }
    //    [UIView animateWithDuration:2.0 animations:^{
    layout.sectionInset = UIEdgeInsetsMake(v+64, h, v, h);
    //    }];
}
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
//{
//  }
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
