#import <UIKit/UIKit.h>
#import "MXEnumHeader.h"
#import "MXPageControl.h"
@class MXImageScrollView;

@protocol MXScrollViewDelegate <NSObject>

@optional
/**添加图片左视图  图片下标index*/
- (UIView *)MXScrollView:(MXImageScrollView* )mxScrollView viewForLeftAccessoryViewAtIndex:(NSInteger)index;

/**左视图跟随拉伸的效果 图片下标index*/
- (UIViewAutoresizing)MXScrollView:(MXImageScrollView *)mxScrollView leftAccessoryViewAutoresizingMaskAtIndex:(NSInteger)index ;

/**添加图片右视图  图片下标index*/
- (UIView *)MXScrollView:(MXImageScrollView *)mxScrollView viewForRightAccessoryViewAtIndex:(NSInteger)index;

/**右视图跟随拉伸的效果 图片下标index*/
- (UIViewAutoresizing)MXScrollView:(MXImageScrollView *)mxScrollView rightAccessoryViewAutoresizingMaskAtIndex:(NSInteger)index ;

@end

@interface MXImageScrollView : UIView

/**传入的图片数组(支持传入图片或图片地址)*/
@property (nonatomic, strong) NSArray *images;

/**点击事件*/
@property (nonatomic, copy) void (^tapImageHandle)(NSInteger index);

/**滑动到某一页回调*/
@property (nonatomic, copy) void (^didScrollImageViewAtIndexHandle)(NSInteger index);

/**滚动方向(默认横向) 竖直滚动时注意系统对滚动视图的自动布局*/
@property (nonatomic, assign) kMXScrollViewDirection scrollDirection;

/**竖直滚动时滚动方向(默认从上到下)*/
@property (nonatomic, assign) kMXVerticalDirection verticalDirection;

/**是否有导航栏 默认为yes 拉伸模式下顶部无导航栏须设置为NO*/
@property (nonatomic, assign) BOOL hasNavigationBar;

/**是否循环滚动 default is yes*/
@property (nonatomic, assign) BOOL loopScroll;

/**自动换页 default is yes*/
@property (nonatomic, assign) BOOL autoScroll;

/**是否显示切换动画 default is no*/
@property (nonatomic, assign) BOOL showAnimotion;

/**是否显示pageControl 默认为yes*/
@property (nonatomic, assign) BOOL showPageIndicator;

/**滑动间隔 default is 3s*/
@property (nonatomic, assign) float scrollIntervalTime;

/**一次动画所需时间 default is 0.5s*/
@property (nonatomic, assign) float animotionDuringTime;


/**内部滚动视图*/
@property (nonatomic, readonly, strong) UIScrollView *rootScrollView;

/**内部表视图*/
@property (nonatomic, readonly, strong) UITableView *rootTableView;

/**pageControll分页视图*/
@property (nonatomic, readonly, strong) MXPageControl *pageControl;

/**预加载视图,须写在设置图片数组之前*/
@property (nonatomic, strong) UIImage *placeholderImage;

/**pageControl位置,上,下,左,又,四个位置*/
@property (nonatomic, assign) kMXPageControlPosition pageControlPosition;

/**animotion*/
@property (nonatomic, strong) CATransition *animation;

/**动画类型*/
@property (nonatomic, assign) kMXTransitionType animotionType;

/**动画方向*/
@property (nonatomic, assign) kMXTransitionDirection animotionDirection;

@property (nonatomic, assign) id <MXScrollViewDelegate> delegate;

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
- (void)stretchingSubviews;

/**
 *  释放定时器,可以写在viewWillDisappear里
 */
- (void)invalidateTimer;

@end
