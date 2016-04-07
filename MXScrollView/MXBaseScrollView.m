//
//  CMCyclicScroll.m
//  CMCyclicScrollDemo
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 desn. All rights reserved.
//

#import "MXBaseScrollView.h"
#import "MXScrollConst.h"
#import "MXTransaction.h"
#import "MXImageView.h"

@interface MXBaseScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) NSArray *originViews;
@property (nonatomic, strong) NSMutableArray *contents;//内容物数组
@property (nonatomic, strong) NSMutableArray *contentViews;//内容物视图数组
@property (nonatomic, strong) UIImageView *currentView;
@property (nonatomic, assign) CGFloat scrollViewWidth;
@property (nonatomic, assign) CGFloat scrollViewHeight;
@property (nonatomic, assign) kMXScrollViewType currentType;

@end

@implementation MXBaseScrollView

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
    _showAnimotion                  = NO;
    _hasNavigationBar               = YES;
    _autoScroll                     = YES;
    _loopScroll                     = YES;
    _scrollIntervalTime             = kMXScrollDuringTime;
    _animotionDuringTime            = kMXAnimotionDuringTime;
    _scrollDirection                = kMXScrollViewDirectionHorizontal;
    _pageControlPosition            = kMXPageControlPositionCenter;
    _placeholderImage               = KDEFAULT_PLACEHOLDER_IMAGE;
    _animation                      = [MXTransaction defaultTransition];
    _contents                       = [NSMutableArray array];
    _contentViews                   = [NSMutableArray array];
    [self initScrollView];
    [self initTimer];
}

#pragma mark - property set
- (void)setViews:(NSArray *)views
            type:(kMXScrollViewType)type {
    NSParameterAssert(views);
    _originViews = views;
    _currentType = type;
    [self refreshViews];
    if (_loopScroll) {
        [_contents addObject:views.lastObject];
        [_contents addObjectsFromArray:views];
        [_contents addObject:views.firstObject];
    } else {
        [_contents addObjectsFromArray:views];
    }
    
    [_contents enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                NSUInteger idx,
                                                BOOL * _Nonnull stop) {
        switch (type) {
            case kMXScrollViewTypeImageView:
                [self initImageWithObject:obj index:idx];
                break;
            case kMXScrollViewTypeCustom:
                
                break;
            case kMXScrollViewTypeLabel:
                
                break;
        }
    }];
    
    switch (_scrollDirection) {
        case kMXScrollViewDirectionHorizontal: {
            _rootScrollView.contentSize = CGSizeMake(_contents.count * _scrollViewWidth, 0);
            if (_loopScroll) _rootScrollView.contentOffset = CGPointMake(_scrollViewWidth, 0);
        }
            break;
        case kMXScrollViewDirectionVertical: {
            _rootScrollView.contentSize = CGSizeMake(0, _contents.count * _scrollViewHeight);
            if (_loopScroll) _rootScrollView.contentOffset = CGPointMake(0, _scrollViewHeight);
        }
            break;
        default:
            break;
    }
    
    _currentView = _loopScroll ? _contentViews[1] : _contentViews.firstObject;
    [self initPageControl];
}

- (void)setScrollDirection:(kMXScrollViewDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    if (_originViews) [self setViews:_originViews type:_currentType];
}

- (void)setAutoScroll:(BOOL)autoScroll {
    if (!autoScroll) dispatch_suspend(_timer);
}

- (void)setLoopScroll:(BOOL)loopScroll {
    _loopScroll = loopScroll;
    [self setAutoScroll:loopScroll];
    if (_originViews) [self setViews:_originViews type:_currentType];
}

-  (void)setShowPageIndicator:(BOOL)showPageIndicator {
    _pageControl.hidden = showPageIndicator;
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
    _animation.type = [MXTransaction getAnimotionType:animotionType];
}

- (void)setAnimotionDirection:(kMXTransitionDirection)animotionDirection {
    _animation.subtype = [MXTransaction getAnimotionDirection:animotionDirection];
}

- (void)setPageControlPosition:(kMXPageControlPosition)pageControlPosition {
    _pageControlPosition = pageControlPosition;
    if (_pageControl) [_pageControl setPosition:_pageControlPosition];
}

#pragma mark - Need implementation method
- (void)stretchingSubviews {
    CGFloat y = _rootTableView.contentOffset.y + (_hasNavigationBar ? kMXNavigationBarHeight : 0);
    if (y < -_scrollViewHeight) {
        CGRect orginFrame = self.frame;
        orginFrame.origin.y = y;
        orginFrame.size.height = -y;
        [self resetSubViewsFrame:orginFrame];
    }
}

- (void)invalidateTimer {
    if (_timer) _timer = nil;
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = 0;
    NSInteger page  = 0;
    switch (_scrollDirection) {
        case kMXScrollViewDirectionHorizontal: {
            index = scrollView.contentOffset.x / _scrollViewWidth;
            if (_loopScroll) {
                if (index == 0) {
                    scrollView.contentOffset = CGPointMake(_scrollViewWidth * (_contents.count - 2), 0);
                } else if (index == _contents.count - 1) {
                    scrollView.contentOffset = CGPointMake(_scrollViewWidth, 0);
                }
            }
            page = scrollView.contentOffset.x / _scrollViewWidth;
        }
            break;
        case kMXScrollViewDirectionVertical: {
            index = scrollView.contentOffset.y / _scrollViewHeight;
            if (_loopScroll) {
                if (index == 0) {
                    scrollView.contentOffset = CGPointMake(0, _scrollViewHeight * (_contents.count - 2));
                } else if (index == _contents.count - 1) {
                    scrollView.contentOffset = CGPointMake(0, _scrollViewHeight);
                }
            }
            page = scrollView.contentOffset.y / _scrollViewHeight;
        }
        default:
            break;
    }
    _pageControl.currentPage = _loopScroll ? page - 1 : page;
    //_currentView = _loopScroll ? _contentViews[page - 1] : _contentViews[page];
    _currentView = _contentViews[page];
    _rootTableView.scrollEnabled = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    dispatch_suspend(_timer);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    switch (_scrollDirection) {
        case kMXScrollViewDirectionHorizontal:
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
            break;
        case kMXScrollViewDirectionVertical:
            scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
            break;
        default:
            break;
    }
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
    CGRect imageFrame = CGRectZero;
    switch (_scrollDirection) {
        case kMXScrollViewDirectionHorizontal:
            imageFrame = CGRectMake(index * _scrollViewWidth,
                               0,
                               _scrollViewWidth,
                               _scrollViewHeight);
            break;
        case kMXScrollViewDirectionVertical:
            imageFrame = CGRectMake(0,
                               index * _scrollViewHeight,
                               _scrollViewWidth,
                               _scrollViewHeight);
        default:
            break;
    }
    MXImageView *scrollImage = [[MXImageView alloc] initWithFrame:imageFrame
                                                         hasTable:_rootTableView != nil];
    [scrollImage setImageWithSource:object
                   placeholderImage:_placeholderImage];
    [scrollImage setDidTapImageViewHandle:^{
        if (_tapHandle) _tapHandle(imageIndex);
    }];
    [self implementationDelegateMethod:scrollImage index:imageIndex];
    [_contentViews addObject:scrollImage];
    [_rootScrollView addSubview:scrollImage];
}

- (void)initScrollView {
    _rootScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.autoresizesSubviews = YES;
    _rootScrollView.backgroundColor = [UIColor clearColor];
    _rootScrollView.delegate = self;
    [self addSubview:_rootScrollView];
}

- (void)initPageControl {
    if (_pageControl) [_pageControl removeFromSuperview];
    NSInteger pageCount = _loopScroll ? _contents.count - 2 : _contents.count;
    _pageControl = [[MXPageControl alloc] initWithFrame:CGRectMake(0,
                                                                   _scrollViewHeight- kMXPageControlHeight,
                                                                   _scrollViewWidth,
                                                                   kMXPageControlHeight)
                                                  pages:pageCount];
    [_pageControl setPosition:_pageControlPosition];
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
        if (_contents.count == 0) return;
        if (_rootTableView) {
            CGRect orginFrame = CGRectMake(0, -_scrollViewHeight, _scrollViewWidth, _scrollViewHeight);
            [self resetSubViewsFrame:orginFrame];
            CGFloat navgationBarHeight = _hasNavigationBar ? kMXNavigationBarHeight : 0;
            if (_rootTableView.contentOffset.y < -_scrollViewHeight - navgationBarHeight) {
                _rootTableView.contentOffset = CGPointMake(0, -_scrollViewHeight - navgationBarHeight);
                _rootTableView.scrollEnabled = NO;
            }
        }
        CGPoint offset = CGPointZero;
        switch (_scrollDirection) {
            case kMXScrollViewDirectionHorizontal:
                offset = CGPointMake(_rootScrollView.contentOffset.x + _scrollViewWidth, 0);
                break;
            case kMXScrollViewDirectionVertical:
                offset = CGPointMake(0, _rootScrollView.contentOffset.y + _scrollViewHeight);
            default:
                break;
        }
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

- (void)refreshViews {
    [_contents removeAllObjects];
    [_contentViews removeAllObjects];
    [_rootScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj,
                                                           NSUInteger idx,
                                                           BOOL * _Nonnull stop) {
        if ([obj isMemberOfClass:[UIView class]]) {
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
    switch (_scrollDirection) {
        case kMXScrollViewDirectionHorizontal:
            _currentView.frame = CGRectMake(_currentView.frame.origin.x,
                                             0,
                                             CGRectGetWidth(frame),
                                             CGRectGetHeight(frame));
            break;
        case kMXScrollViewDirectionVertical:
            _currentView.frame = CGRectMake(0,
                                             _currentView.frame.origin.y,
                                             CGRectGetWidth(frame),
                                             CGRectGetHeight(frame));
        default:
            break;
    }
    
}

#pragma mark - implementation delegate method
- (void)implementationDelegateMethod:(MXImageView *)mxImageView
                               index:(NSInteger)index {
#if 0
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
#endif
}

@end
