//
//  MXBaseScrollView.m
//  MXScrollViewDemo
//
//  Created by apple on 16/3/23.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import "MXBaseScrollView.h"

@interface MXBaseScrollView ()

@end

@implementation MXBaseScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.autoresizesSubviews = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
