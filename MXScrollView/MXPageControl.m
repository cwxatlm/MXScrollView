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

@end

@implementation MXPageControl

- (instancetype)initWithFrame:(CGRect)frame
                        pages:(NSInteger)pages {
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfPages = pages;
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.currentPageIndicatorTintColor = KDEFAULT_PAGECONTROL_COLOR;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _scrollViewWidth = CGRectGetWidth(frame);
    }
    return self;
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
