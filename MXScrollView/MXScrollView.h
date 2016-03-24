#import <UIKit/UIKit.h>
#import "MXEnmuHeader.h"
@class MXBaseScrollView;
@class MXPageControl;
@class MXScrollView;

@protocol MXScrollViewDelegate <NSObject>

@optional
/**添加图片左视图  图片下标index*/
- (UIView *)MXScrollView:(MXScrollView *)mxScrollView viewForImageLeftAccessoryViewAtIndex:(NSInteger)index;

/**左视图跟随拉伸的效果 图片下标index*/
- (UIViewAutoresizing)MXScrollView:(MXScrollView *)mxScrollView leftAccessoryViewAutoresizingMaskAtIndex:(NSInteger)index ;

/**添加图片右视图  图片下标index*/
- (UIView *)MXScrollView:(MXScrollView *)mxScrollView viewForImageRightAccessoryViewAtIndex:(NSInteger)index;

/**右视图跟随拉伸的效果 图片下标index*/
- (UIViewAutoresizing)MXScrollView:(MXScrollView *)mxScrollView rightAccessoryViewAutoresizingMaskAtIndex:(NSInteger)index ;

@end

/**图片的拉伸类型为自适应，如果发现图片出现重叠，覆盖，交叉，请调整高度后再运行
 Stretch type picture for adaptive, if found images overlap, coverage, cross, please adjust the height after operation*/
@interface MXScrollView : UIView
/**点击回调*/
@property (nonatomic, copy) void (^tapImageHandle)(NSInteger index);

/**传入的图片数组(支持传入图片或图片地址)*/
@property (nonatomic, strong) NSArray *images;

/**是否有导航栏 默认为yes 拉伸模式下顶部无导航栏须设置为NO
 * If loaded on tableView and no navigationBar, must set this property value NO
 */
@property (nonatomic, assign) BOOL hasNavigationBar;

/**自动换页 default is yes*/
@property (nonatomic, assign) BOOL autoScroll;

/**是否显示切换动画 default is yse(pageCurl) 为no时为平滑切换效果*/
@property (nonatomic, assign) BOOL showAnimotion;//

/**是否显示分页视图 默认为yes*/
@property (nonatomic, assign) BOOL showPageIndicator;

/**是否显示分页视图背景(半透明黑色背景) default is no*/
@property (nonatomic, assign) BOOL showPageIndicatorBottonLine;

/**滑动间隔 default is 3s*/
@property (nonatomic, assign) float scrollIntervalTime;

/**一次动画所需时间 default is 0.5s*/
@property (nonatomic, assign) float animotionDuringTime;


/**内部滚动视图*/
@property (nonatomic, readonly, strong) MXBaseScrollView *rootScrollView;

/**内部表视图*/
@property (nonatomic, readonly, strong) UITableView *rootTableView;

/**pageControll分页视图*/
@property (nonatomic, readonly, strong) MXPageControl *pageControl;

/**have left center right position, default is center*/
@property (nonatomic, assign) kMXPageControlPosition pageControlPosition;

/**预加载视图,须写在设置图片数组之前 set it before set images*/
@property (nonatomic, strong) UIImage *placeholderImage;


/**animotion*/
@property (nonatomic, strong) CATransition *animation;

/**动画类型*/
@property (nonatomic, assign) kMXTransitionType animotionType;

/**动画方向*/
@property (nonatomic, assign) kMXTransitionDirection animotionDirection;

/**设置代理后可设置图片左右视图*/
@property (nonatomic, assign) id<MXScrollViewDelegate> delegate;

#pragma mark - 方法

/**
 *  普通模式创建一个MXScrollView
 *
 *  @param frame 位置
 *
 *  @return 实例化对象
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  TableView模式(无导航栏需设置hasNavigationBar为NO)
 *
 *  @param frame         位置
 *  @param rootTableView 根TableView
 *
 *  @return 实例化对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                rootTableView:(UITableView *)rootTableView;

/**
 *  拉伸图片 加载在tableView上面时，须在scrollViewDidScroll代理中实现本方法方可拉伸图片
 */
- (void)stretchingImage;

/**
 *  释放定时器,可以写在viewWillDisappear里
 */
- (void)invalidateTimer;

@end
