//
//  CMCyclicScroll.m
//  CMCyclicScrollDemo
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 desn. All rights reserved.
//

#import "MXScrollView.h"
#import "MXScrollConst.h"
#import "MXScrollView+Animotion.h"

@interface MXScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) NSMutableArray *scrollImages;
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) UIImageView *currentImage;
@property (nonatomic, assign) CGFloat scrollViewWidth;
@property (nonatomic, assign) CGFloat scrollViewHeight;

@end

@implementation MXScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollViewHeight = CGRectGetHeight(frame);
        _scrollViewWidth  = CGRectGetWidth(frame);
        [self initBaseData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                rootTableView:(UITableView *)rootTableView {
    NSParameterAssert(rootTableView);
    self = [self initWithFrame:CGRectMake(frame.origin.x,
                                          -CGRectGetHeight(frame),
                                          CGRectGetWidth(frame),
                                          CGRectGetHeight(frame))];
    if (self) {
        _rootTableView = rootTableView;
        _rootTableView.contentInset = UIEdgeInsetsMake(CGRectGetHeight(frame), 0, 0, 0);
        [_rootTableView addSubview:self];
    }
    return self;
}

- (void)initBaseData {
    _showAnimotion                  = YES;
    _hasNavigationBar               = YES;
    _autoScroll                     = YES;
    _scrollIntervalTime             = kMXScrollDuringTime;
    _animotionDuringTime            = kMXAnimotionDuringTime;
    _pageControlPosition            = kMXPageControlPositionCenter;
    _placeholderImage               = KDEFAULT_PLACEHOLDER_IMAGE;
    _animation                      = [MXScrollView defaultTransition];
    _imageViews                     = [NSMutableArray array];
    _scrollImages                   = [NSMutableArray array];
    _rootScrollView                 = [[MXBaseScrollView alloc] initWithFrame:self.bounds];
    _rootScrollView.delegate        = self;
    _showPageIndicatorBottonLine    = NO;
    self.backgroundColor            = [UIColor clearColor];
    [self addSubview:_rootScrollView];
    [self initTimer];
}

#pragma mark - property set
- (void)setImages:(NSArray *)images {
    NSParameterAssert(images);
    
    [self refreshImages];
    [_scrollImages addObject:images.lastObject];
    [_scrollImages addObjectsFromArray:images];
    [_scrollImages addObject:images.firstObject];
    
    [_scrollImages enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                NSUInteger idx,
                                                BOOL * _Nonnull stop) {
        [self initImageWithObject:obj index:idx];
    }];
    
    _rootScrollView.contentSize = CGSizeMake(self.scrollImages.count * _scrollViewWidth, 0);
    _rootScrollView.contentOffset = CGPointMake(_scrollViewWidth, 0);
    _currentImage = _imageViews[1];
    
    [self initPageControl];
    
}

- (void)setAutoScroll:(BOOL)autoScroll {
    if (!autoScroll) dispatch_suspend(_timer);
}

-  (void)setShowPageIndicator:(BOOL)showPageIndicator {
    _pageControl.hidden = showPageIndicator;
}

- (void)setShowPageIndicatorBottonLine:(BOOL)showPageIndicatorBottonLine {
    _showPageIndicatorBottonLine = showPageIndicatorBottonLine;
    if (_pageControl) _pageControl.bottonLine.hidden = !_showPageIndicatorBottonLine;
}

- (void)setScrollIntervalTime:(float)scrollIntervalTime {
    dispatch_source_set_timer(_timer,
                              dispatch_time(DISPATCH_TIME_NOW, scrollIntervalTime * NSEC_PER_SEC),
                              (uint64_t)(scrollIntervalTime * NSEC_PER_SEC),
                              0);
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    _placeholderImage = placeholderImage;
}

- (void)setAnimotionType:(kMXTransitionType)animotionType {
    _animation.type = [MXScrollView getAnimotionType:animotionType];
}

- (void)setAnimotionDirection:(kMXTransitionDirection)animotionDirection {
    _animation.subtype = [MXScrollView getAnimotionDirection:animotionDirection];
}

- (void)setPageControlPosition:(kMXPageControlPosition)pageControlPosition {
    _pageControlPosition = pageControlPosition;
    if (_pageControl) [_pageControl setPosition:_pageControlPosition];
}

#pragma mark - Need implementation method
- (void)stretchingImage {
    CGFloat y = _rootTableView.contentOffset.y + (_hasNavigationBar ? kMXNavigationBarHeight : 0);
    if (y < -_scrollViewHeight) {
        CGRect orginFrame = self.frame;
        orginFrame.origin.y = y;
        orginFrame.size.height = -y;
        [self resetSubViewsFrame:orginFrame];
    }
}

- (void)invalidateTimer {
    _timer = nil;
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / _scrollViewWidth;
    if (index == 0) {
        scrollView.contentOffset = CGPointMake(_scrollViewWidth * (_scrollImages.count - 2), 0);
    } else if (index == _scrollImages.count - 1) {
        scrollView.contentOffset = CGPointMake(_scrollViewWidth, 0);
    }
    NSInteger page = scrollView.contentOffset.x / _scrollViewWidth;
    _pageControl.currentPage = page - 1;
    _currentImage = _imageViews[page];
    _rootTableView.scrollEnabled = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    dispatch_suspend(_timer);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (!_autoScroll) return;
    dispatch_source_set_timer(_timer,
                              dispatch_time(DISPATCH_TIME_NOW, _scrollIntervalTime * NSEC_PER_SEC),
                              (uint64_t)(_scrollIntervalTime * NSEC_PER_SEC),
                              0);
    dispatch_resume(_timer);
}

#pragma mark - private method

- (void)initImageWithObject:(id)object
                      index:(NSInteger)index {
    NSInteger imageIndex = index - 1;
    MXImageView *scrollImage = [[MXImageView alloc] initWithFrame:CGRectMake(index * _scrollViewWidth,
                                                                             0,
                                                                             _scrollViewWidth,
                                                                             _scrollViewHeight)
                                                         hasTable:_rootTableView != nil];
    [scrollImage setImageWithSource:object
                   placeholderImage:_placeholderImage];
    [scrollImage setDidTapImageViewHandle:^{
        if (_tapImageHandle) _tapImageHandle(imageIndex);
    }];
    [self implementationDelegateMethod:scrollImage index:imageIndex];
    [_imageViews addObject:scrollImage];
    [_rootScrollView addSubview:scrollImage];
}

- (void)initPageControl {
    if (_pageControl) [_pageControl removeFromSuperview];
    _pageControl = [[MXPageControl alloc] initWithFrame:CGRectMake(0,
                                                                   _scrollViewHeight- kMXPageControlHeight,
                                                                   _scrollViewWidth,
                                                                   kMXPageControlHeight)
                                        superViewHeight:_scrollViewHeight
                                                  pages:_scrollImages.count - 2];
    [_pageControl setPosition:_pageControlPosition];
    _pageControl.bottonLine.hidden = !_showPageIndicatorBottonLine;
    [self addSubview:_pageControl.bottonLine];
    [self addSubview:_pageControl];
}


- (void)initTimer {
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
                                    0,
                                    0,
                                    dispatch_get_main_queue());
    dispatch_source_set_timer(_timer,
                              dispatch_time(DISPATCH_TIME_NOW, _scrollIntervalTime * NSEC_PER_SEC),
                              (uint64_t)(_scrollIntervalTime * NSEC_PER_SEC),
                              0);
    // 设置回调
    dispatch_source_set_event_handler(_timer, ^{
        if (_scrollImages.count == 0) return;
        if (_rootTableView) {
            CGRect orginFrame = CGRectMake(0, -_scrollViewHeight, _scrollViewWidth, _scrollViewHeight);
            [self resetSubViewsFrame:orginFrame];
            CGFloat navgationBarHeight = _hasNavigationBar ? kMXNavigationBarHeight : 0;
            if (_rootTableView.contentOffset.y < -_scrollViewHeight - navgationBarHeight) {
                _rootTableView.contentOffset = CGPointMake(0, -_scrollViewHeight - navgationBarHeight);
                _rootTableView.scrollEnabled = NO;
            }
        }
        CGPoint offset = CGPointMake(_rootScrollView.contentOffset.x + _scrollViewWidth, 0);
        if (_showAnimotion) {
            _rootScrollView.contentOffset = offset;
            [_rootScrollView.layer addAnimation:_animation forKey:nil];
        } else {
            [UIView animateWithDuration:_animotionDuringTime animations:^{
                _rootScrollView.contentOffset = offset;
            }];
        }
        [self scrollViewDidEndDecelerating:_rootScrollView];
    });
    
    // 启动定时器
    dispatch_resume(_timer);
}

- (void)refreshImages {
    [_scrollImages removeAllObjects];
    [_imageViews   removeAllObjects];
    [_rootScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj,
                                                           NSUInteger idx,
                                                           BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[MXImageView class]]) {
            [obj removeFromSuperview];
        }
    }];
}

- (void)resetSubViewsFrame:(CGRect)frame {
    self.frame = frame;
    _rootScrollView.frame = CGRectMake(0,
                                       0,
                                       CGRectGetWidth(frame),
                                       CGRectGetHeight(frame));
    _currentImage.frame = CGRectMake(_currentImage.frame.origin.x,
                                     0,
                                     CGRectGetWidth(frame),
                                     CGRectGetHeight(frame));
}

#pragma mark - implementation delegate method
- (void)implementationDelegateMethod:(MXImageView *)mxImageView
                               index:(NSInteger)index {
    
    if ([self.delegate respondsToSelector:@selector(MXScrollView:viewForImageLeftAccessoryViewAtIndex:)]) {
        UIView *leftAccessoryView = [self.delegate MXScrollView:self
                           viewForImageLeftAccessoryViewAtIndex:index];
        if ([self.delegate respondsToSelector:@selector(MXScrollView:leftAccessoryViewAutoresizingMaskAtIndex:)]) {
            UIViewAutoresizing leftViewAutoresizingMark = [self.delegate MXScrollView:self
                                             leftAccessoryViewAutoresizingMaskAtIndex:index];
            leftAccessoryView.autoresizingMask = leftViewAutoresizingMark;
        } else {
            leftAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        }
        [mxImageView addSubview:leftAccessoryView];
    }
    
    if ([self.delegate respondsToSelector:@selector(MXScrollView:viewForImageRightAccessoryViewAtIndex:)]) {
        UIView *rightAccessoryView = [self.delegate MXScrollView:self
                           viewForImageRightAccessoryViewAtIndex:index];
        if ([self.delegate respondsToSelector:@selector(MXScrollView:rightAccessoryViewAutoresizingMaskAtIndex:)]) {
            UIViewAutoresizing leftViewAutoresizingMark = [self.delegate MXScrollView:self
                                            rightAccessoryViewAutoresizingMaskAtIndex:index];
            rightAccessoryView.autoresizingMask = leftViewAutoresizingMark;
        } else {
            rightAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        }
        [mxImageView addSubview:rightAccessoryView];
    }
}

@end
