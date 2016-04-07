//
//  MXScrollHeader.h
//  MXScrollViewDemo
//
//  Created by apple on 16/3/23.
//  Copyright © 2016年 PRO. All rights reserved.
//

#ifndef MXEnumHeader_h
#define MXEnumHeader_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, kMXScrollViewDirection) {
    /**
     *  水平滚动
     */
    kMXScrollViewDirectionHorizontal,
    /**
     *  竖直滚动
     */
    kMXScrollViewDirectionVertical
};

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
     *  向上翻一页(私有API,可能影响审核)
     */
    kMXTransitionPageCurl,
    /**
     *  向下翻一页(私有API,可能影响审核)
     */
    kMXTransitionPageUnCurl,
    /**
     *  滴水效果(私有API,可能影响审核)
     */
    kMXTransitionRippleEffect,
    /**
     *  收缩效果,如同mac的神奇效果(私有API,可能影响审核)
     */
    kMXTransitionSuckEffect,
    /**
     *  立方体效果(私有API,可能影响审核)
     */
    kMXTransitionCube,
    /**
     *  上下翻转效果(私有API,可能影响审核)
     */
    kMXTransitionOglFlip,
    /**
     *  随机效果(私有API,可能影响审核)
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

//pageControl位置
typedef NS_ENUM(NSInteger, kMXScrollViewType) {
    /**
     *  图片类型
     */
    kMXScrollViewTypeImageView,
    /**
     *  标签类型
     */
    kMXScrollViewTypeLabel,
    /**
     *  自定义类型
     */
    kMXScrollViewTypeCustom,
};

#endif /* MXScrollHeader_h */
