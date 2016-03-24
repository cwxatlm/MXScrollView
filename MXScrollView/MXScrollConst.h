
#ifndef __MXScrollConst__H__
#define __MXScrollConst__H__

#import <Foundation/Foundation.h>

#define KDEFAULT_PAGECONTROL_COLOR       [UIColor whiteColor] //默认pageControl当前页数颜色
#define KDEFAULT_PLACEHOLDER_IMAGE       [UIImage imageNamed:@"MXScrollView.bundle/placeholderPicture"] //默认等待视图

extern CGFloat const kMXScrollViewHeight; //默认滚动视图高度
extern CGFloat const kMXPageControlHeight; //pageControl高度
extern CGFloat const kMXNavigationBarHeight;//导航栏高度

extern float const kMXScrollDuringTime; //默认滚动时间
extern float const kMXAnimotionDuringTime; //默认动画时间

extern int const kAnimotionTypeCounts;//动画类型数量
extern int const kAnimotionDirectionCounts;//动画方向数量

#endif