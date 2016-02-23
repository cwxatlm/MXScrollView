//
//  MXScrollView+Animotion.h
//  MXScrollViewDemo
//
//  Created by PRO on 16/2/23.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import "MXScrollView.h"
#import "MXScrollConst.h"

@interface MXScrollView (Animotion)

//获取动画类型
- (NSString *)getAnimotionType:(kCMTransitionType)type;
//获取动画方向
- (NSString *)getAnimotionDirection:(kCMTransitionDirection)direction;

@end
