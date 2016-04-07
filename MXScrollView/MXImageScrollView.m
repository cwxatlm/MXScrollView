//
//  MXImageScrollView.m
//  MXScrollViewDemo
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import "MXImageScrollView.h"

@implementation MXImageScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                rootTableView:(UITableView *)rootTableView {
    self = [super initWithFrame:frame rootTableView:rootTableView];
    if (self) {

    }
    return self;
}

- (void)setImages:(NSArray *)images {
    [self setViews:images type:kMXScrollViewTypeImageView];
}

- (void)stretchingSubviews {
    [super stretchingSubviews];
}

- (void)invalidateTimer {
    [super invalidateTimer];
}

- (void)setTapImageHandle:(void (^)(NSInteger))tapImageHandle {
    self.tapHandle = tapImageHandle;
}

@end
