//
//  MXScrollHeader.h
//  MXScrollViewDemo
//
//  Created by apple on 16/3/23.
//  Copyright © 2016年 PRO. All rights reserved.
//

#ifndef MXScrollHeader_h
#define MXScrollHeader_h

//特效类型
typedef NS_ENUM(NSInteger, kMXTransitionType) {
    /**
     *  交叉淡化过渡
     */
    kMXTransitionMoveIn,
    /**
     *  新视图移到旧视图上面
     */
    kMXTransitionFade,
    /**
     *  新视图把旧视图推出去
     */
    kMXTransitionPush,
    /**
     *  将旧视图移开,显示下面的新视图
     */
    kMXTransitionReveal,
    /**
     *  向上翻一页
     */
    kMXTransitionPageCurl,
    /**
     *  向下翻一页
     */
    kMXTransitionPageUnCurl,
    /**
     *  滴水效果
     */
    kMXTransitionRippleEffect,
    /**
     *  收缩效果,如同mac的神奇效果
     */
    kMXTransitionSuckEffect,
    /**
     *  立方体效果
     */
    kMXTransitionCube,
    /**
     *  上下翻转效果
     */
    kMXTransitionOglFlip,
    /**
     *  随机效果
     */
    kMXTransitionRandom
};

//特效方向
typedef NS_ENUM(NSInteger, kMXTransitionDirection) {
    /**
     *  从右到左
     */
    kMXTransitionDirectionFromRight,
    /**
     *  从左到右
     */
    kMXTransitionDirectionFromLeft,
    /**
     *  从下到上
     */
    kMXTransitionDirectionFromBottom,
    /**
     *  从上到下
     */
    kMXTransitionDirectionFromTop,
    /**
     *  随机
     */
    kMXTransitionDirectionRandom
};

//pageControl位置
typedef NS_ENUM(NSInteger, kMXPageControlPosition) {
    /**
     *  中间
     */
    kMXPageControlPositionCenter,
    /**
     *  左边
     */
    kMXPageControlPositionLeft,
    /**
     *  右边
     */
    kMXPageControlPositionRight,
};

#endif /* MXScrollHeader_h */
