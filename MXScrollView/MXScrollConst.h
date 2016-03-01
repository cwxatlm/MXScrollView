
#ifndef __MXScrollConst__H__
#define __MXScrollConst__H__

#import <Foundation/Foundation.h>

//转场特效类型
typedef NS_ENUM(NSInteger, kCMTransitionType) {
    /**
     *  交叉淡化过渡
     */
    kCMTransitionMoveIn,
    /**
     *  新视图移到旧视图上面
     */
    kCMTransitionFade,
    /**
     *  新视图把旧视图推出去
     */
    kCMTransitionPush,
    /**
     *  将旧视图移开,显示下面的新视图
     */
    kCMTransitionReveal,
    /**
     *  向上翻一页
     */
    kCMTransitionPageCurl,
    /**
     *  向下翻一页
     */
    kCMTransitionPageUnCurl,
    /**
     *  滴水效果
     */
    kCMTransitionRippleEffect,
    /**
     *  收缩效果,如同mac的神奇效果
     */
    kCMTransitionSuckEffect,
    /**
     *  立方体效果
     */
    kCMTransitionCube,
    /**
     *  上下翻转效果
     */
    kCMTransitionOglFlip,
    /**
     *  随机效果
     */
    kCMTransitionRandom
};

typedef NS_ENUM(NSInteger, kCMTransitionDirection) {
    /**
     *  从右到左
     */
    kCMTransitionDirectionFromRight,
    /**
     *  从左到右
     */
    kCMTransitionDirectionFromLeft,
    /**
     *  从下到上
     */
    kCMTransitionDirectionFromBottom,
    /**
     *  从上到下
     */
    kCMTransitionDirectionFromTop,
    /**
     *  随机
     */
    kCMTransitionDirectionRandom
};

#define KSCREEN_WIDTH                    [UIScreen mainScreen].bounds.size.width //屏幕宽
#define KDEFAULT_PAGECONTROL_COLOR       [UIColor whiteColor] //默认pageControl当前页数颜色
#define KDEFAULT_PLACEHOLDER_IMAGE       [UIImage imageNamed:@"MXScrollView.bundle/placeholderPicture"] //默认等待视图

extern float const kDefaultScrollViewHeight; //默认滚动视图高度
extern float const kDefaultPageControlHeight; //pageControl高度
extern float const kDefaultScrollTime; //默认滚动时间
extern float const kDefaultAnimotionTime; //默认动画时间
extern float const kDefaultNavigationBarHeight;//导航栏高度



#endif