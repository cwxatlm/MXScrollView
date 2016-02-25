
#import <UIKit/UIKit.h>

@interface UIImageView (LoadImage)

- (void)cm_downloadImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)placeholderImage;

@end
