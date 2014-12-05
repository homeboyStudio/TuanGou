//日志输出宏定义
#ifdef DEBUG
#define MyLog(...) NSLog(__VA_ARGS__)
#else
#define MyLog(...) /* */
#endif

//1.Dock上的条目的尺寸
#define kDockItemW 100
#define kDockItemH 80
//顶部菜单项的宽高
#define kTopMenuItemW 120
#define kTopMenuItemH 44
//底部菜单项的宽高
#define kBottomMenuItemW 120
#define kBottomMenuItemH 70

// 3.通知名称
#define kCityChangeNote @"city_change"         //城市改变的通知
#define kCategoryChangeNote @"category_change" //分类改变通知
#define kDistrictChangeNote @"district_change" //区域改变通知
#define kOrderChangeNote   @"order_change"     //排序
// 城市的key
#define kCityKey @"city"
#define kAddAllNotes(method) \
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(method) name:kCityChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(method) name:kCategoryChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(method) name:kDistrictChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(method) name:kOrderChangeNote object:nil];

//4.全局背景颜色
#define kGlobalBg [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]]
//5.默认动画时间
#define kDefaultAnimDuration 0.4
//6.固定的字符串
#define kAllCategory @"全部分类"
#define kAllDistrict @"全部商区"
#define kAll   @"全部"