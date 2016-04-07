#import <UIKit/UIKit.h>
#import "MXEnumHeader.h"
#import "MXPageControl.h"

//@protocol MXScrollViewDelegate <NSObject>
//
//@optional
///**添加图片左视图  图片下标index*/
//- (UIView *)MXScrollView:( *)mxScrollView viewForImageLeftAccessoryViewAtIndex:(NSInteger)index;
//
///**左视图跟随拉伸的效果 图片下标index*/
//- (UIViewAutoresizing)MXScrollView:(MXScrollView *)mxScrollView leftAccessoryViewAutoresizingMaskAtIndex:(NSInteger)index ;
//
///**添加图片右视图  图片下标index*/
//- (UIView *)MXScrollView:(MXScrollView *)mxScrollView viewForImageRightAccessoryViewAtIndex:(NSInteger)index;
//
///**右视图跟随拉伸的效果 图片下标index*/
//- (UIViewAutoresizing)MXScrollView:(MXScrollView *)mxScrollView rightAccessoryViewAutoresizingMaskAtIndex:(NSInteger)index ;
//
//@end

/**图片的拉伸类型为自适应，如果发现图片出现重叠，覆盖，交叉，请调整高度后再运行*/
@interface MXBaseScrollView : UIView

/**传入的内容物数组*/
@property (nonatomic, strong) NSArray *views;

/**点击回调*/
@property (nonatomic, copy) void (^tapHandle)(NSInteger index);

#pragma mark - 属性设置
/**滚动方向(默认横向)*/
@property (nonatomic, assign) kMXScrollViewDirection scrollDirection;

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
//@property (nonatomic, assign) id<MXScrollViewDelegate> delegate;

#pragma mark - 方法

- (instancetype)initWithFrame:(CGRect)frame
                rootTableView:(UITableView *)rootTableView;

- (void)stretchingSubviews;

- (void)invalidateTimer;

#pragma mark - 子类实现
/**
 *  设置内容物
 *
 *  @param views 内容物数组
 *  @param type  类型
 */
- (void)setViews:(NSArray *)views
            type:(kMXScrollViewType)type;

@end
