
#import "MXScrollView+Animotion.h"
#import "MXScrollConst.h"

@implementation MXScrollView (Animotion)

+ (CATransition *)defaultTransition {
    CATransition *animation = [CATransition animation];
    animation.duration = kMXAnimotionDuringTime;
    animation.type = [self getAnimotionType:kMXTransitionPageCurl];
    animation.subtype = [self getAnimotionDirection:kMXTransitionDirectionFromRight];
    return animation;
}

+ (NSString *)getAnimotionType:(kMXTransitionType)MXType {
    switch (MXType) {
        case kMXTransitionMoveIn:
            return kCATransitionMoveIn;
        case kMXTransitionFade:
            return kCATransitionFade;
        case kMXTransitionPush:
            return kCATransitionPush;
        case kMXTransitionReveal:
            return kCATransitionReveal;
        case kMXTransitionPageCurl:
            return @"pageCurl";
        case kMXTransitionPageUnCurl:
            return @"pageUnCurl";
        case kMXTransitionCube:
            return @"cube";
        case kMXTransitionOglFlip:
            return @"oglFlip";
        case kMXTransitionRippleEffect:
            return @"rippleEffect";
        case kMXTransitionSuckEffect:
            return @"suckEffect";
        case kMXTransitionRandom:
            return [self getAnimotionType:arc4random_uniform(kAnimotionTypeCounts)];
        default:
            break;
    }
}

+ (NSString *)getAnimotionDirection:(kMXTransitionDirection)MXDirection {
    switch (MXDirection) {
        case kMXTransitionDirectionFromBottom:
            return kCATransitionFromBottom;
        case kMXTransitionDirectionFromLeft:
            return kCATransitionFromLeft;
        case kMXTransitionDirectionFromRight:
            return kCATransitionFromRight;
        case kMXTransitionDirectionFromTop:
            return kCATransitionFromTop;
        case kMXTransitionDirectionRandom:
            return [self getAnimotionDirection:arc4random_uniform(kAnimotionDirectionCounts)];
        default:
            break;
    }
}


@end
