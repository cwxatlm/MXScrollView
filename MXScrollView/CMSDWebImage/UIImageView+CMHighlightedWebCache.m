/*
 * This file is part of the CMSDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+CMHighlightedWebCache.h"
#import "UIView+CMWebCacheOperation.h"

#define UIImageViewHighlightedWebCacheOperationKey @"highlightedImage"

@implementation UIImageView (HighlightedWebCache)

- (void)CMSD_setHighlightedImageWithURL:(NSURL *)url {
    [self CMSD_setHighlightedImageWithURL:url options:0 progress:nil completed:nil];
}

- (void)CMSD_setHighlightedImageWithURL:(NSURL *)url options:(CMSDWebImageOptions)options {
    [self CMSD_setHighlightedImageWithURL:url options:options progress:nil completed:nil];
}

- (void)CMSD_setHighlightedImageWithURL:(NSURL *)url completed:(CMSDWebImageCompletionBlock)completedBlock {
    [self CMSD_setHighlightedImageWithURL:url options:0 progress:nil completed:completedBlock];
}

- (void)CMSD_setHighlightedImageWithURL:(NSURL *)url options:(CMSDWebImageOptions)options completed:(CMSDWebImageCompletionBlock)completedBlock {
    [self CMSD_setHighlightedImageWithURL:url options:options progress:nil completed:completedBlock];
}

- (void)CMSD_setHighlightedImageWithURL:(NSURL *)url options:(CMSDWebImageOptions)options progress:(CMSDWebImageDownloaderProgressBlock)progressBlock completed:(CMSDWebImageCompletionBlock)completedBlock {
    [self CMSD_cancelCurrentHighlightedImageLoad];

    if (url) {
        __weak __typeof(self)wself = self;
        id<CMSDWebImageOperation> operation = [CMSDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, CMSDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe (^
                                     {
                                         if (!wself) return;
                                         if (image && (options & CMSDWebImageAvoidAutoSetImage) && completedBlock)
                                         {
                                             completedBlock(image, error, cacheType, url);
                                             return;
                                         }
                                         else if (image) {
                                             wself.highlightedImage = image;
                                             [wself setNeedsLayout];
                                         }
                                         if (completedBlock && finished) {
                                             completedBlock(image, error, cacheType, url);
                                         }
                                     });
        }];
        [self CMSD_setImageLoadOperation:operation forKey:UIImageViewHighlightedWebCacheOperationKey];
    } else {
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:CMSDWebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            if (completedBlock) {
                completedBlock(nil, error, CMSDImageCacheTypeNone, url);
            }
        });
    }
}

- (void)CMSD_cancelCurrentHighlightedImageLoad {
    [self CMSD_cancelImageLoadOperationWithKey:UIImageViewHighlightedWebCacheOperationKey];
}

@end


@implementation UIImageView (HighlightedWebCacheDeprecated)

- (void)setHighlightedImageWithURL:(NSURL *)url {
    [self CMSD_setHighlightedImageWithURL:url options:0 progress:nil completed:nil];
}

- (void)setHighlightedImageWithURL:(NSURL *)url options:(CMSDWebImageOptions)options {
    [self CMSD_setHighlightedImageWithURL:url options:options progress:nil completed:nil];
}

- (void)setHighlightedImageWithURL:(NSURL *)url completed:(CMSDWebImageCompletedBlock)completedBlock {
    [self CMSD_setHighlightedImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSError *error, CMSDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}

- (void)setHighlightedImageWithURL:(NSURL *)url options:(CMSDWebImageOptions)options completed:(CMSDWebImageCompletedBlock)completedBlock {
    [self CMSD_setHighlightedImageWithURL:url options:options progress:nil completed:^(UIImage *image, NSError *error, CMSDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}

- (void)setHighlightedImageWithURL:(NSURL *)url options:(CMSDWebImageOptions)options progress:(CMSDWebImageDownloaderProgressBlock)progressBlock completed:(CMSDWebImageCompletedBlock)completedBlock {
    [self CMSD_setHighlightedImageWithURL:url options:0 progress:progressBlock completed:^(UIImage *image, NSError *error, CMSDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}

- (void)cancelCurrentHighlightedImageLoad {
    [self CMSD_cancelCurrentHighlightedImageLoad];
}

@end
