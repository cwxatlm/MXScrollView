#import <UIKit/UIKit.h>
#import "MXScrollConst.h"


//图片的拉伸类型为自适应，如果发现图片出现重叠，覆盖，交叉，请调整高度后再运行

@interface MXScrollView : UIView

/**
 *  传入的图片数组(支持传入图片或图片地址)
 */
@property (nonatomic, strong) NSArray *images;
/**
 *  点击图片时的回调
 */
@property (nonatomic, copy) void (^tapImageHandle)(NSInteger index);

@property (nonatomic, assign) BOOL hasNavigationBar; //是否有导航栏 默认为yes 拉伸模式下顶部无导航栏须设置为NO
@property (nonatomic, assign) BOOL autoScroll; //自动换页 默认为yes

@property (nonatomic, assign) BOOL showAnimotion;//是否显示切换动画 默认为yes 为no时为平滑切换效果

@property (nonatomic, assign) float scrollIntervalTime; //滑动间隔 默认3秒

//UIKit
@property (nonatomic, strong) UIScrollView *scrollView;//滚动视图

@property (nonatomic, strong) UITableView *tableView;//表视图

@property (nonatomic, strong) UIImage *placeholderImage;//预加载视图,须写在设置图片数组之前

//pageIndicator
@property (nonatomic, assign) BOOL showPageIndicator; //是否显示分页视图 默认为yes

@property (nonatomic, strong) UIColor *pageIndicatorCurrentColor; //默认为白色

@property (nonatomic, strong) UIColor *pageIndicatorBackColor; //默认为系统浅灰

//animotion
@property (nonatomic, assign) kCMTransitionType animotionType; //动画类型

@property (nonatomic, assign) kCMTransitionDirection animotionDirection;//动画方向

@property (nonatomic, assign) float animotionTime; //动画持续时间

#pragma mark - 方法
/**
 *  创建一个Scrollview(高度默认,200)
 *
 *  @param tableView  根tabelView
 *
 *  @return 实例化对象
 */
- (instancetype)initWithRootTableView:(UITableView *)tableView;

/**
 *  创建一个自定义高度scrollView
 *
 *  @param tableView 根tableView
 *  @param height    滚动视图高度
 *
 *  @return 实例化对象
 */
- (instancetype)initWithRootTableView:(UITableView *)tableView height:(float)height;

/**
 *  拉伸图片 加载在tableView上面时，须在scrollViewDidScroll代理中实现本方法方可拉伸图片
 */
- (void)stretchingImage;

@end
