//
//  CMCyclicScroll.m
//  CMCyclicScrollDemo
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 desn. All rights reserved.
//

#import "MXScrollView.h"
#import "UIImageView+LoadImage.h"
#import "MXScrollView+Animotion.h"

@interface MXScrollView () <UIScrollViewDelegate>
{
    BOOL needAnimotion;//控制是否需要动画
    BOOL isTabelViewMode;//是否是加在tableView上
    NSMutableArray *imageViews;//图片控件数组;
    UIImageView *currentImage;//当前图片
    NSInteger currentPage;//当前页数
}
//内部scrollView
@property (nonatomic, strong) UIScrollView *scrollView;
//scrollview高度
@property (nonatomic, assign) CGFloat scrollViewHeight;
//scrollView宽度
@property (nonatomic, assign) CGFloat scrollViewWidth;
//动画时间
@property (nonatomic, assign) float duringTime;
//实际滚动图片数组
@property (nonatomic, strong) NSMutableArray *scrollImages;
//引用滚动视图
@property (nonatomic, strong) UITableView *tableView;
//pageControll分页视图
@property (nonatomic, strong) UIPageControl *pageControl;
//定时器
@property (nonatomic, strong) NSTimer *timer;
//转场动画
@property (nonatomic, strong) CATransition *animation;
//单独scrollView的frame记录
@property (nonatomic, assign) CGRect newFrame;

@end

@implementation MXScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    _newFrame = frame;
    self = [self initWithRootTableView:nil height:frame.size.height];
    isTabelViewMode = NO;
    return self;
}

- (instancetype)initWithRootTableView:(UITableView *)tableView {
    self = [self initWithRootTableView:tableView height:kDefaultScrollViewHeight];
    return self;
}

- (instancetype)initWithRootTableView:(UITableView *)tableView height:(float)height {
    self = [super initWithFrame:tableView == nil ? _newFrame : CGRectMake(0, -height, SCREEN_WIDTH, height)];
    if (self) {
        isTabelViewMode = YES;
        self.showAnimotion = YES;
        self.hasNavigationBar = YES;
        self.scrollViewHeight = height;
        self.scrollViewWidth = _newFrame.size.width == 0 ? SCREEN_WIDTH : _newFrame.size.width;
        self.duringTime = kDefaultScrollTime;
        self.autoresizesSubviews = YES;
        [self initBaseDataWithTableView:tableView];
        [self initTransaction];
        [self initTimer];
    }
    return self;
}

- (void)setImages:(NSArray *)images {
    self.scrollImages = [NSMutableArray arrayWithObject:[images lastObject]];
    [self.scrollImages addObjectsFromArray:images];
    [self.scrollImages addObject:images.firstObject];
    [self.scrollImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self initImageWithObject:obj index:idx];
    }];
    self.scrollView.contentSize = CGSizeMake(self.scrollImages.count * self.scrollViewWidth, 0);
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
    currentImage = imageViews[1];
    [self initPageControl];
}

- (void)setAutoScroll:(BOOL)autoScroll {
    if (!autoScroll) {
        [_timer invalidate];
        _timer = nil;
    }
}

-  (void)setShowPageIndicator:(BOOL)showPageIndicator {
    self.pageControl.hidden = showPageIndicator;
}

- (void)setPageIndicatorCurrentColor:(UIColor *)pageIndicatorCurrentColor {
    self.pageControl.currentPageIndicatorTintColor = pageIndicatorCurrentColor;
}

- (void)setPageIndicatorBackColor:(UIColor *)pageIndicatorBackColor {
    self.pageControl.pageIndicatorTintColor = pageIndicatorBackColor;
}

- (void)setScrollIntervalTime:(float)scrollIntervalTime {
    self.duringTime = scrollIntervalTime;
    [self initTimer];
}

- (void)setTransition:(CATransition *)transition {
    _animation = transition;
}

- (void)setAnimotionType:(kCMTransitionType)animotionType {
    _animation.type = [self getAnimotionType:animotionType];
}

- (void)setAnimotionDirection:(kCMTransitionDirection)animotionDirection {
    _animation.subtype = [self getAnimotionDirection:animotionDirection];
}

- (void)stretchingImage {
    CGFloat y = _tableView.contentOffset.y + (self.hasNavigationBar ? kDefaultNavigationBarHeight : 0);
    if (y < -self.scrollViewHeight) {
        CGRect orginFrame = self.frame;
        orginFrame.origin.y = y;
        orginFrame.size.height = -y;
        self.frame = orginFrame;
        self.scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(orginFrame), CGRectGetHeight(orginFrame));
        currentImage.frame = CGRectMake(currentImage.frame.origin.x, 0, CGRectGetWidth(orginFrame), CGRectGetHeight(orginFrame));
    }
}

#pragma mark - scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    if (needAnimotion) [self addScorllAnimotion];
    if (index == 0) {
        scrollView.contentOffset = CGPointMake(CGRectGetWidth(scrollView.frame) * (self.scrollImages.count - 2), 0);
    } else if (index == self.scrollImages.count - 1) {
        scrollView.contentOffset = CGPointMake(CGRectGetWidth(scrollView.frame), 0);
    }
    NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    self.pageControl.currentPage = page - 1;
    currentImage = imageViews[page];
    currentPage = page - 1;
    _tableView.scrollEnabled = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    needAnimotion = NO;
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.duringTime]];
}

#pragma mark - 私有方法
#pragma mark -- 初始化基本数据
- (void)initBaseDataWithTableView:(UITableView *)tableView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.scrollViewWidth, self.scrollViewHeight)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.contentMode = !isTabelViewMode ? UIViewContentModeScaleToFill : UIViewContentModeScaleAspectFill;;
    self.autoresizesSubviews = YES;
    tableView.contentInset = UIEdgeInsetsMake(self.scrollViewHeight, 0, 0, 0);
    _tableView = tableView;
    [tableView addSubview:self];
    [self addSubview:self.scrollView];
    
    imageViews = [NSMutableArray array];
}

- (void)initImageWithObject:(id)object index:(NSInteger)index {
    UIImageView *scrollImage = [[UIImageView alloc] initWithFrame:CGRectMake(index * self.scrollViewWidth, 0, self.scrollViewWidth, self.scrollViewHeight)];
    scrollImage.contentMode = !isTabelViewMode ? UIViewContentModeScaleToFill : UIViewContentModeScaleAspectFill;//设置自适应
    scrollImage.autoresizesSubviews = YES;
    scrollImage.userInteractionEnabled = YES;
    if ([object isKindOfClass:[UIImage class]]) {
        scrollImage.image = (UIImage *)object;
    } else if ([object isKindOfClass:[NSString class]]){
        [scrollImage cm_downloadImageWithUrl:[NSURL URLWithString:(NSString *)object] placeholderImage:[UIImage imageNamed:@"MXScrollView.bundle/placeholderPicture"]];
    }
    [self addGestureRecognizerToImageView:scrollImage];
    [imageViews addObject:scrollImage];
    [self.scrollView addSubview:scrollImage];
}

- (void)initPageControl {
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - kDefaultPageControlHeight, self.scrollViewWidth, kDefaultPageControlHeight)];
    self.pageControl.numberOfPages = self.scrollImages.count - 2;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.currentPageIndicatorTintColor = DEFAULT_PAGECONTROL_COLOR;
    self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:self.pageControl];
}

- (void)initTransaction {
    _animation = [CATransition animation];
    _animation.duration = kDefaultAnimotionTime;
    _animation.type = [self getAnimotionType:kCMTransitionPageCurl];
    _animation.subtype = [self getAnimotionDirection:kCMTransitionDirectionFromRight];
}

- (void)initTimer {
    [_timer invalidate];
    _timer = nil;
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.duringTime target:self selector:@selector(imageScroll) userInfo:nil repeats:YES];
}
#pragma mark -- 方法
//定时器方法
- (void)imageScroll {
    if (self.showAnimotion) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + self.scrollViewWidth, 0);
    } else {
        [self normolAnimotion:^{
            self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + self.scrollViewWidth, 0);
        }];
    }
    needAnimotion = YES;
    _tableView.scrollEnabled = NO;
    [self resetFrame];
    [self scrollViewDidEndDecelerating:self.scrollView];
}

- (void)normolAnimotion:(void(^)())block {
    [UIView animateWithDuration:kDefaultAnimotionTime animations:block];
}

- (void)addScorllAnimotion {
    if (self.showAnimotion) [self.scrollView.layer addAnimation:_animation forKey:nil];
}

- (void)resetFrame {
    currentImage.frame = CGRectMake(currentImage.frame.origin.x, 0, self.scrollViewWidth, self.scrollViewHeight);
}

- (void)addGestureRecognizerToImageView:(UIImageView *)imageView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [imageView addGestureRecognizer:tap];
}

//点击图片方法
- (void)tapImageView:(UITapGestureRecognizer *)tap {
    if (self.tapImageHandle) self.tapImageHandle(currentPage);
}

@end
