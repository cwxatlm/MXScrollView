//
//  MXPageControl.m
//  MXScrollViewDemo
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import "MXPageControl.h"
#import "MXScrollConst.h"

@interface MXPageControl ()

@property (nonatomic, assign) CGFloat scrollViewWidth;
@property (nonatomic, assign) CGFloat scrollViewHeight;

@end

@implementation MXPageControl

- (instancetype)initWithFrame:(CGRect)frame
              superViewHeight:(CGFloat)superViewHeight
                        pages:(NSInteger)pages {
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfPages = pages;
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.currentPageIndicatorTintColor = KDEFAULT_PAGECONTROL_COLOR;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _scrollViewWidth = CGRectGetWidth(frame);
        _scrollViewHeight = superViewHeight;
    }
    return self;
}

- (void)setPosition:(kMXPageControlPosition)pisition {
    switch (pisition) {
        case kMXPageControlPositionBottom: {
            self.frame = CGRectMake(0,
                                    _scrollViewHeight - kMXPageControlHeight,
                                    _scrollViewWidth,
                                    kMXPageControlHeight);
        }
            break;
        case kMXPageControlPositionTop: {
            self.frame = CGRectMake(0, 0, _scrollViewWidth, kMXPageControlHeight);
        }
            break;
        case kMXPageControlPositionLeft: {
            self.frame = CGRectMake(- _scrollViewHeight / 2 + kMXPageControlHeight / 2,
                                    (_scrollViewHeight - kMXPageControlHeight) / 2,
                                    _scrollViewHeight,
                                    kMXPageControlHeight);
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
            break;
        case kMXPageControlPositionRight: {
            self.frame = CGRectMake(_scrollViewWidth - _scrollViewHeight / 2 - kMXPageControlHeight / 2,
                                    (_scrollViewHeight - kMXPageControlHeight) / 2,
                                    _scrollViewHeight,
                                    kMXPageControlHeight);
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
            break;
        default:
            break;
    }
}

@end
