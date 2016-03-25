//
//  MXPageControl.m
//  MXScrollViewDemo
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import "MXPageControl.h"
#import "MXScrollConst.h"

static CGFloat const kSinglePageIndicatorWidth = 18;

@interface MXPageControl ()

@property (nonatomic, assign) CGFloat scrollViewWidth;
@property (nonatomic, assign) CGFloat scrollViewHeight;

@end

@implementation MXPageControl

- (instancetype)initWithFrame:(CGRect)frame
              superViewHeight:(CGFloat)height
                        pages:(NSInteger)pages {
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfPages = pages;
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.currentPageIndicatorTintColor = KDEFAULT_PAGECONTROL_COLOR;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _scrollViewWidth = CGRectGetWidth(frame);
        _scrollViewHeight = height;
        [self initBottomLine];
    }
    return self;
}

- (void)initBottomLine {
    
    _bottonLine = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                          _scrollViewHeight - kMXPageControlHeight,
                                                          _scrollViewWidth,
                                                          kMXPageControlHeight)];
    _bottonLine.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _bottonLine.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
}

- (void)setPosition:(kMXPageControlPosition)pisition {
    CGPoint center = self.center;
    self.bounds = CGRectMake(0, 0, self.numberOfPages * kSinglePageIndicatorWidth, kMXPageControlHeight);
    switch (pisition) {
        case kMXPageControlPositionCenter:
            self.center = CGPointMake(_scrollViewWidth / 2, center.y);
            break;
        case kMXPageControlPositionLeft:
            self.center = CGPointMake(self.bounds.size.width / 2, center.y);
            break;
        case kMXPageControlPositionRight:
            self.center = CGPointMake(_scrollViewWidth - self.bounds.size.width / 2, center.y);
            break;
        default:
            break;
    }
}

@end
