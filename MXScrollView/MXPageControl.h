//
//  MXPageControl.h
//  MXScrollViewDemo
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXEnmuHeader.h"

@interface MXPageControl : UIPageControl

@property (nonatomic, strong) UIView *bottonLine;//底部黑色半透明背景条

- (instancetype)initWithFrame:(CGRect)frame
              superViewHeight:(CGFloat)height
                        pages:(NSInteger)pages;

- (void)setPosition:(kMXPageControlPosition)pisition;

@end
