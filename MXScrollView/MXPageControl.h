//
//  MXPageControl.h
//  MXScrollViewDemo
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXEnumHeader.h"

@interface MXPageControl : UIPageControl

- (instancetype)initWithFrame:(CGRect)frame
              superViewHeight:(CGFloat)superViewHeight
                        pages:(NSInteger)pages;

- (void)setPosition:(kMXPageControlPosition)pisition;

@end
