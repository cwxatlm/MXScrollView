//
//  MXTransaction.h
//  MXScrollViewDemo
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MXEnumHeader.h"

@interface MXTransaction : CATransaction

/***Create default transition*/
+ (CATransition *)defaultTransition;

/***Get system animotion type from kCMTransitionType*/
+ (NSString *)getAnimotionType:(kMXTransitionType)CMType;

/***Get system AnimotionDirection kCMTransitionType*/
+ (NSString *)getAnimotionDirection:(kMXTransitionDirection)CMDirection;

@end
