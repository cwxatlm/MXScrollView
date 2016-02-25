
#import "UIImageView+LoadImage.h"

@implementation UIImageView (LoadImage)

- (void)cm_downloadImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)placeholderImage
{
    if (placeholderImage) {
        self.image = placeholderImage;
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error = %@", error.description);
        }
        UIImage *downloadImage = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = downloadImage;
        });
        
    }];
    [task resume];
}

@end
