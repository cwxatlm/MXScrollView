
#import "MXScrollView.h"
#import "MXScrollConst.h"

@interface MXScrollView (Animotion)

/***Create default transition*/
+ (CATransition *)defaultTransition;

/***Get system animotion type from kCMTransitionType*/
+ (NSString *)getAnimotionType:(kMXTransitionType)CMType;

/***Get system AnimotionDirection kCMTransitionType*/
+ (NSString *)getAnimotionDirection:(kMXTransitionDirection)CMDirection;

@end
